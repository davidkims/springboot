#!/bin/bash
# Update data for program directories, creating them when missing.
# Writes a timestamped file under data/ for each program updated.
set -euo pipefail

# Default program directories
DEFAULT_PROGRAMS=(
  "bulk"
  "finance_app"
  "rust-example"
  "src"
)

# Determine programs to update
if [ "$#" -gt 0 ] && [ -n "${1:-}" ] && [ "$1" != "all" ]; then
  PROGRAMS=("$@")
else
  PROGRAMS=("${DEFAULT_PROGRAMS[@]}")
fi

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
DATA_DIR="$ROOT_DIR/data"
LOG_DIR="$ROOT_DIR/.github/logs"
mkdir -p "$DATA_DIR" "$LOG_DIR"

for prog in "${PROGRAMS[@]}"; do
  mkdir -p "$ROOT_DIR/$prog"
  timestamp=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
  echo "$timestamp" > "$DATA_DIR/${prog}_last_updated.txt"
  echo "[update] $prog -> $timestamp" | tee -a "$LOG_DIR/update_all_data.log"
done
