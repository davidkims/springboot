"""Download and generate service tokens on a schedule.

This script loads a list of services and their token download URLs from
``services.json`` located in the same directory. For each service, it attempts
to download a token from the provided URL. If the download fails, a new token is
randomly generated. Tokens are stored under ``tokens/<service>.token``.

The process repeats every five minutes to ensure fresh tokens are always
available.
"""

from __future__ import annotations

import json
import logging
import os
import time
import secrets
from pathlib import Path
from typing import Dict
from urllib import request, error

CONFIG_PATH = Path(__file__).with_name("services.json")
TOKENS_DIR = Path(__file__).with_name("tokens")
REFRESH_INTERVAL = 300  # five minutes


def load_services() -> Dict[str, str]:
    """Load the service-to-URL mapping from ``services.json``."""
    with CONFIG_PATH.open("r", encoding="utf-8") as fh:
        return json.load(fh)


def download_token(service: str, url: str) -> str | None:
    """Download a token from ``url`` for ``service``.

    Returns the token string if successful, otherwise ``None``.
    """
    try:
        with request.urlopen(url, timeout=10) as resp:
            return resp.read().decode().strip()
    except Exception as exc:  # pylint: disable=broad-except
        logging.error("Failed to download token for %s: %s", service, exc)
        return None


def generate_token() -> str:
    """Generate a new random token."""
    return secrets.token_hex(16)


def save_token(service: str, token: str) -> None:
    """Persist ``token`` for ``service`` under the tokens directory."""
    TOKENS_DIR.mkdir(exist_ok=True)
    token_path = TOKENS_DIR / f"{service}.token"
    token_path.write_text(token, encoding="utf-8")


def refresh_tokens(services: Dict[str, str]) -> None:
    """Refresh tokens for all provided ``services``."""
    for service, url in services.items():
        token = download_token(service, url) or generate_token()
        save_token(service, token)
        logging.info("Token for %s refreshed", service)


def main() -> None:
    logging.basicConfig(level=logging.INFO, format="%(asctime)s %(message)s")
    services = load_services()
    while True:
        refresh_tokens(services)
        time.sleep(REFRESH_INTERVAL)


if __name__ == "__main__":  # pragma: no cover - simple CLI entrypoint
    main()
