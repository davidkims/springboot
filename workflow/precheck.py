#!/usr/bin/env python3
"""Pre-check utilities for workflow validation and code conflict reporting."""

from pathlib import Path
import sys

REPO_ROOT = Path(__file__).resolve().parents[1]
REPORT_PATH = Path(__file__).resolve().parent / "conflict_report.txt"


def check_conflicts() -> list[str]:
    """Return a list of files that contain unresolved git conflict markers."""
    conflict_files: list[str] = []
    for path in REPO_ROOT.rglob("*"):
        if (
            not path.is_file()
            or any(part in path.parts for part in (".git", "__pycache__"))
        ):
            continue
        try:
            text = path.read_text(encoding="utf-8", errors="ignore")
        except Exception:
            continue
        for line in text.splitlines():
            if line.startswith("<<<<<<<") or line.startswith("=======") or line.startswith(">>>>>>>"):
                conflict_files.append(str(path.relative_to(REPO_ROOT)))
                break
    return conflict_files


def write_conflict_report(conflicts: list[str]) -> None:
    """Write a conflict report to REPORT_PATH."""
    if conflicts:
        REPORT_PATH.write_text("\n".join(conflicts) + "\n")
    else:
        REPORT_PATH.write_text("No conflicts detected.\n")


def run_prechecks() -> bool:
    """Run all prechecks and return True if they pass."""
    conflicts = check_conflicts()
    write_conflict_report(conflicts)
    if conflicts:
        print("[precheck] Code conflicts detected:")
        for f in conflicts:
            print(f" - {f}")
        print(f"[precheck] 자세한 내용은 {REPORT_PATH} 에서 확인하세요")
        return False
    print("[precheck] 코드 충돌 없음")
    return True


if __name__ == "__main__":
    ok = run_prechecks()
    sys.exit(0 if ok else 1)
