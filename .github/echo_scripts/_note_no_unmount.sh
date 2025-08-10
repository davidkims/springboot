#!/usr/bin/env bash
set -Eeuo pipefail
export PS4='+ [2025-08-10 07:45:49] _helpers.sh:9:write_echo ▶ '
set -x
echo '[NOTE] This run intentionally leaves /mnt/gh-disk mounted (no unmount per request).'
