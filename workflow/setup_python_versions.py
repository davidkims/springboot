#!/usr/bin/env python3
"""Utility script to generate workflow artifacts for multiple Python versions.

For each requested Python version, this script creates a directory under
``workflow/generated`` containing:

* ``install.sh`` – shell commands to install the specific Python version.
* ``permissions.txt`` – placeholder permission configuration.
* ``account.txt`` – simulated virtual account information.
* ``firewall.txt`` – example firewall rule file.
* ``ipinfo.txt`` – randomly generated virtual IP information.
* ``upgrade.sh`` – shell commands to upgrade the specific Python version.

The script does not actually perform installation or networking changes; instead it
produces files that could be used by other automation steps.
"""
from __future__ import annotations

import ipaddress
import os
import random
import secrets
from pathlib import Path
from typing import Iterable, List

BASE_DIR = Path(__file__).parent / "generated"


def _write_executable(path: Path, content: str) -> None:
    """Write *content* to *path* and mark it executable."""
    path.write_text(content)
    # 0o755 gives owner rwx and group/world rx
    os.chmod(path, 0o755)


def _create_version_dir(version: str) -> Path:
    """Create and return a directory for a specific *version*."""
    ver_dir = BASE_DIR / f"python{version}"
    ver_dir.mkdir(parents=True, exist_ok=True)
    return ver_dir


def _generate_virtual_ip() -> str:
    """Return a random IPv4 address as a string."""
    return str(ipaddress.IPv4Address(random.randint(0, 2 ** 32 - 1)))


def _generate_account() -> str:
    """Return a placeholder account identifier."""
    return f"acct_{secrets.token_hex(8)}"


def generate_for_version(version: str) -> None:
    """Generate workflow artifacts for a given Python *version*."""
    ver_dir = _create_version_dir(version)

    # installation script
    install_content = (
        "#!/bin/bash\n"
        f"apt-get update && apt-get install -y python{version}\n"
    )
    _write_executable(ver_dir / "install.sh", install_content)

    # permission file
    (ver_dir / "permissions.txt").write_text(
        f"Permissions for Python {version}\n"
    )

    # virtual account file
    (ver_dir / "account.txt").write_text(_generate_account() + "\n")

    # firewall file
    firewall_rule = (
        "# Example firewall rule allowing SSH from a private subnet\n"
        "ufw allow from 192.168.0.0/16 to any port 22\n"
    )
    (ver_dir / "firewall.txt").write_text(firewall_rule)

    # IP information file
    (ver_dir / "ipinfo.txt").write_text(_generate_virtual_ip() + "\n")

    # upgrade script
    upgrade_content = (
        "#!/bin/bash\n"
        f"apt-get install --only-upgrade -y python{version}\n"
    )
    _write_executable(ver_dir / "upgrade.sh", upgrade_content)


# Default versions to process when run as a script
DEFAULT_VERSIONS: List[str] = ["3.8", "3.9", "3.10"]


def generate(versions: Iterable[str] = DEFAULT_VERSIONS) -> None:
    """Generate artifacts for each version in *versions*."""
    BASE_DIR.mkdir(exist_ok=True)
    for ver in versions:
        generate_for_version(ver)


if __name__ == "__main__":
    generate()
