#!/usr/bin/env python3
"""Utility to locate and optionally delete provenance files.

By default this script performs a dry run and lists files or directories
whose names contain the word "provenance".  Use the ``--delete`` flag to
remove them from the filesystem.
"""

from __future__ import annotations

import argparse
import logging
import sys
from pathlib import Path
from typing import Iterable


def find_provenance_paths(root: Path) -> Iterable[Path]:
    """Yield all paths under ``root`` containing 'provenance' in the name."""
    for path in root.rglob("*"):
        if "provenance" in path.name:
            yield path


def delete_path(path: Path) -> None:
    """Delete ``path`` whether it's a file or directory."""
    if path.is_dir():
        for child in sorted(path.rglob("*"), reverse=True):
            if child.is_file() or child.is_symlink():
                child.unlink()
            else:
                child.rmdir()
        path.rmdir()
    else:
        path.unlink()


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(
        description="Find and optionally delete provenance files",
    )
    parser.add_argument(
        "--root",
        type=Path,
        default=Path("."),
        help="Directory to scan (defaults to current working directory)",
    )
    parser.add_argument(
        "--delete",
        action="store_true",
        help="Delete files instead of performing a dry run",
    )
    parser.add_argument(
        "--verbose",
        "-v",
        action="store_true",
        help="Enable verbose logging",
    )
    args = parser.parse_args(argv)

    logging.basicConfig(
        level=logging.DEBUG if args.verbose else logging.INFO,
        format="%(message)s",
    )

    root = args.root.resolve()
    logging.debug("Scanning %s", root)
    targets = list(find_provenance_paths(root))

    if not targets:
        logging.info("No provenance files found.")
        return 0

    logging.info("Found %d provenance path(s).", len(targets))
    for path in targets:
        logging.info(path)
        if args.delete:
            delete_path(path)
            logging.debug("Deleted %s", path)

    if not args.delete:
        logging.info("Dry run complete. Use --delete to remove files.")

    return 0


if __name__ == "__main__":  # pragma: no cover - entry point
    sys.exit(main())
