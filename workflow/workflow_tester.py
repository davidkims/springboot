#!/usr/bin/env python3
"""Workflow verification script.

Runs lightweight checks against workflow utilities to ensure they behave as
expected. The script performs the following validations:

* run the pre-check to confirm no merge conflicts exist
* generate temporary artifacts for a fake Python version and verify expected
  files are created
* exercise bulk workflow helpers for disk, table, and query generation

The script returns a non-zero exit code if any check fails.
"""

from __future__ import annotations

import shutil
import sqlite3
from pathlib import Path

from precheck import run_prechecks
import setup_python_versions
from bulk_workflow import (
    create_disks,
    create_tables,
    generate_queries,
    DB_PATH,
    DISK_DIR,
)

BASE_DIR = Path(__file__).resolve().parent
GENERATED_DIR = BASE_DIR / "generated"


def validate_precheck() -> bool:
    """Return True if the pre-check passes."""
    return run_prechecks()


def validate_python_versions() -> bool:
    """Generate artifacts for a temporary Python version and verify output."""
    test_version = "99.0"
    version_dir = GENERATED_DIR / f"python{test_version}"
    if version_dir.exists():
        shutil.rmtree(version_dir)
    setup_python_versions.generate([test_version])
    expected = {
        "install.sh",
        "permissions.txt",
        "account.txt",
        "firewall.txt",
        "ipinfo.txt",
        "upgrade.sh",
    }
    present = {p.name for p in version_dir.iterdir()}
    ok = expected <= present
    shutil.rmtree(version_dir)
    return ok


def validate_bulk_workflow() -> bool:
    """Run bulk workflow helpers and ensure artifacts are produced."""
    if DISK_DIR.exists():
        shutil.rmtree(DISK_DIR)
    if DB_PATH.exists():
        DB_PATH.unlink()
    with sqlite3.connect(DB_PATH) as conn:
        create_disks(1)
        create_tables(conn, 1)
        queries = generate_queries(1)
        conn.execute("INSERT INTO table_0 (id, value) VALUES (1, 'ok')")
        conn.commit()
        result = conn.execute("SELECT value FROM table_0 WHERE id = 1").fetchone()
    ok = (
        (DISK_DIR / "disk_0.img").exists()
        and result == ("ok",)
        and len(queries) == 1
    )
    if DISK_DIR.exists():
        shutil.rmtree(DISK_DIR)
    if DB_PATH.exists():
        DB_PATH.unlink()
    return ok


def main() -> int:
    checks = {
        "precheck": validate_precheck(),
        "python_versions": validate_python_versions(),
        "bulk_workflow": validate_bulk_workflow(),
    }
    for name, passed in checks.items():
        print(f"[{name}] {'OK' if passed else 'FAIL'}")
    return 0 if all(checks.values()) else 1


if __name__ == "__main__":
    raise SystemExit(main())
