#!/usr/bin/env bash
set -Eeuo pipefail
export PS4='+ [2025-08-10 07:46:52] _helpers.sh:9:write_echo ▶ '
set -x
mkdir -p "logs" "/mnt/gh-disk/logs"
sudo chown -R "runner:runner" "logs" "/mnt/gh-disk/logs"
sudo chmod "0755" "logs" "/mnt/gh-disk/logs"
[ -e "logs/.gitkeep" ] || : > "logs/.gitkeep"
