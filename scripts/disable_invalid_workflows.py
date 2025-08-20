#!/usr/bin/env python3
"""Disable GitHub workflows with YAML syntax errors.

This utility scans ``.github/workflows`` for YAML files and attempts to
parse each one. If a file contains a syntax error, it is renamed with a
``.disabled`` suffix so that GitHub no longer executes it.

Run the script from the repository root::

    python scripts/disable_invalid_workflows.py

Use ``--dry-run`` to only report problematic files without renaming them.
"""

from __future__ import annotations

import argparse
from pathlib import Path
from typing import Iterable

import yaml

WORKFLOW_DIR = Path(__file__).resolve().parents[1] / ".github" / "workflows"


def iter_workflow_files() -> Iterable[Path]:
    """Yield all workflow files with .yml or .yaml extensions."""
    yield from WORKFLOW_DIR.glob("*.yml")
    yield from WORKFLOW_DIR.glob("*.yaml")


def disable_invalid(dry_run: bool = False) -> list[Path]:
    """Return a list of workflows that were disabled due to syntax errors."""
    disabled: list[Path] = []
    for path in iter_workflow_files():
        # Skip already disabled workflows
        if path.suffix.endswith(".disabled"):
            continue
        try:
            with path.open("r", encoding="utf-8") as fh:
                yaml.safe_load(fh)
        except yaml.YAMLError:
            target = path.with_suffix(path.suffix + ".disabled")
            if dry_run:
                print(f"[DRY-RUN] Would disable {path.name}")
            else:
                path.rename(target)
                print(f"Disabled {path.name}")
            disabled.append(path)
    return disabled


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--dry-run",
        action="store_true",
        help="report problematic files without renaming",
    )
    args = parser.parse_args()

    disabled = disable_invalid(dry_run=args.dry_run)
    if not disabled:
        print("No invalid workflow files found.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
