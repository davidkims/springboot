#!/usr/bin/env python3
"""Delete failed GitHub workflow runs using Defender Bot.

This utility scans the most recent workflow runs in a repository and
forcefully deletes any runs that concluded with ``failure``. It relies on the
GitHub REST API and requires a personal access token with ``repo`` and
``workflow`` scopes. The token should be provided via the ``GITHUB_TOKEN``
environment variable. The target repository defaults to
``davidkims/springboot`` but can be overridden with the ``REPO`` environment
variable.
"""

from __future__ import annotations

import argparse
import os
import sys
from typing import Iterable

import requests

API_ROOT = "https://api.github.com"
REPO = os.environ.get("REPO", "davidkims/springboot")


def get_session() -> requests.Session:
    """Return an authenticated session using ``GITHUB_TOKEN``."""
    token = os.environ.get("GITHUB_TOKEN")
    if not token:
        print("GITHUB_TOKEN environment variable must be set", file=sys.stderr)
        sys.exit(1)
    session = requests.Session()
    session.headers.update(
        {
            "Authorization": f"token {token}",
            "Accept": "application/vnd.github+json",
        }
    )
    return session


def fetch_json(session: requests.Session, url: str, **kwargs) -> dict:
    """GET helper returning JSON with error handling."""
    resp = session.get(url, timeout=30, **kwargs)
    resp.raise_for_status()
    return resp.json()


def list_failed_runs(session: requests.Session) -> Iterable[dict]:
    """Yield workflow runs that concluded with failure."""
    url = f"{API_ROOT}/repos/{REPO}/actions/runs"
    params = {"status": "completed", "per_page": 100}
    data = fetch_json(session, url, params=params)
    for run in data.get("workflow_runs", []):
        if run.get("conclusion") == "failure":
            yield run


def delete_run(session: requests.Session, run_id: int) -> bool:
    """Delete the workflow run with ``run_id``. Return True on success."""
    url = f"{API_ROOT}/repos/{REPO}/actions/runs/{run_id}"
    resp = session.delete(url, timeout=30)
    return resp.status_code == 204


def cleanup_failed_runs(session: requests.Session, dry_run: bool = False) -> None:
    """Remove all failed workflow runs. If ``dry_run`` is True, only list them."""
    runs = list(list_failed_runs(session))
    if not runs:
        print("No failed workflow runs found.")
        return
    for run in runs:
        run_id = run.get("id")
        name = run.get("name", "unknown")
        if dry_run:
            print(f"[dry-run] Would delete run {run_id} ({name})")
            continue
        if delete_run(session, run_id):
            print(f"Deleted run {run_id} ({name})")
        else:
            print(f"Failed to delete run {run_id} ({name})", file=sys.stderr)


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--dry-run", action="store_true", help="List failed runs without deleting"
    )
    args = parser.parse_args()
    session = get_session()
    cleanup_failed_runs(session, dry_run=args.dry_run)


if __name__ == "__main__":
    main()
