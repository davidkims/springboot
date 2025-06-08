#!/usr/bin/env bash
set -euo pipefail

# Check GitHub workflow files for YAML issues

if ! command -v yamllint >/dev/null; then
  echo "yamllint is not installed" >&2
  exit 1
fi

yamllint .github/workflows "$@"
