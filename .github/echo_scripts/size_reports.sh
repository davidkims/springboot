#!/usr/bin/env bash
set -Eeuo pipefail
export PS4='+ [2025-08-10 07:46:53] _helpers.sh:9:write_echo ▶ '
set -x
mkdir -p .github/echo_monitoring
du -ah . | sort -hr | head -n 50 > .github/echo_monitoring/top_file_sizes.txt || true
du -sh . > .github/echo_monitoring/total_size.txt || true
df -h > .github/echo_monitoring/df_all.txt || true
