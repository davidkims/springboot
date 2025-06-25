#!/usr/bin/env bash
set -euo pipefail

# commit_github_files.sh - Add and commit all files under the .github directory.
# Usage: ./commit_github_files.sh [commit-message]
# If no commit message is provided, a default one will be used.

DEFAULT_MESSAGE="chore: update .github files"

main() {
  local message=${1:-$DEFAULT_MESSAGE}

  # Stage .github directory
  git add .github

  # Commit if there are staged changes
  if ! git diff --cached --quiet; then
    git commit -m "$message"
  else
    echo "No changes to commit in .github"
  fi
}

main "$@"
