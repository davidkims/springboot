#!/usr/bin/env bash
set -Eeuo pipefail
export PS4='+ [2025-08-10 08:30:48] _helpers.sh:8:write_echo ▶ '
set -x
mkdir -p "logs" "/mnt/gh-disk/logs" "/mnt/gh-disk/part2/logs"
sudo chown -R "runner:runner" "logs" "/mnt/gh-disk/logs" "/mnt/gh-disk/part2/logs"
sudo chmod "0755" "logs" "/mnt/gh-disk/logs" "/mnt/gh-disk/part2/logs"
[ -e "logs/.gitkeep" ] || : > "logs/.gitkeep"
