#!/usr/bin/env python3
"""Delete existing Dependabot workflow files and configuration.

This script removes the Dependabot configuration file and any workflows
related to Dependabot within the repository's `.github` directory.
"""
from pathlib import Path


def delete_dependabot_files(base_dir: Path = Path(".")) -> list[Path]:
    """Delete Dependabot files found under ``base_dir``.

    Parameters
    ----------
    base_dir: Path
        Base directory from which to search for Dependabot files.

    Returns
    -------
    list[Path]
        List of paths that were deleted.
    """
    deleted: list[Path] = []

    github_dir = base_dir / ".github"

    # Delete Dependabot configuration file if present.
    config_file = github_dir / "dependabot.yml"
    if config_file.exists():
        config_file.unlink()
        deleted.append(config_file)

    # Remove any workflow files that mention Dependabot in their filename.
    workflows_dir = github_dir / "workflows"
    if workflows_dir.exists():
        for pattern in ("*dependabot*.yml", "*dependabot*.yaml"):
            for file_path in workflows_dir.glob(pattern):
                if file_path.is_file():
                    file_path.unlink()
                    deleted.append(file_path)

    return deleted


def main() -> None:
    deleted_files = delete_dependabot_files()
    if deleted_files:
        for path in deleted_files:
            print(f"Deleted {path}")
    else:
        print("No Dependabot workflows found.")


if __name__ == "__main__":
    main()
