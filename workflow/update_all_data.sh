#!/bin/bash
# Update data for all known programs in this repository.
# This script writes a timestamped file under the data/ directory for
# each program to indicate when it was refreshed.
set -euo pipefail

# List of program directories to update
PROGRAMS=(
  "bulk"
  "finance_app"
  "rust-example"
  "src"
)

DATA_DIR="$(cd "$(dirname "$0")/.." && pwd)/data"
mkdir -p "$DATA_DIR"

for prog in "${PROGRAMS[@]}"; do
  if [ -d "$prog" ]; then
    timestamp=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
    echo "$timestamp" > "$DATA_DIR/${prog}_last_updated.txt"
    echo "[update] $prog -> $timestamp"
  else
    echo "[skip] $prog (directory not found)"
  fi
done
