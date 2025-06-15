#!/bin/bash
# optimize_disk.sh - Manage disk usage for given directories.
# Usage: optimize_disk.sh DIR [DIR...]
# Creates backups and removes old files if disk usage exceeds threshold.

set -euo pipefail

THRESHOLD="${DISK_THRESHOLD:-90}"

check_usage() {
  local path="$1"
  local usage
  usage=$(df -P "$path" | awk 'NR==2 {print $5}' | tr -d '%')
  echo "$usage"
}

cleanup_dir() {
  local dir="$1"
  local timestamp
  timestamp=$(date +"%Y%m%d%H%M%S")
  local backup="${dir%/}_backup_${timestamp}.tar.gz"
  tar -czf "$backup" -C "$(dirname "$dir")" "$(basename "$dir")"
  echo "Backup created at $backup"
  # Remove files older than 30 days to free space
  find "$dir" -type f -mtime +30 -print -delete
}

main() {
  if [ "$#" -eq 0 ]; then
    echo "Usage: $0 DIR [DIR...]" >&2
    exit 1
  fi

  for dir in "$@"; do
    if [ ! -d "$dir" ]; then
      echo "Skipping non-directory $dir" >&2
      continue
    fi

    usage=$(check_usage "$dir")
    echo "Disk usage for $(df -P "$dir" | awk 'NR==2 {print $6}') is ${usage}%"
    if [ "$usage" -ge "$THRESHOLD" ]; then
      echo "Usage exceeds ${THRESHOLD}%. Cleaning $dir..."
      cleanup_dir "$dir"
    else
      echo "Usage within limit for $dir"
    fi
  done
}

main "$@"
