#!/usr/bin/env bash
set -Eeuo pipefail
export PS4='+ [2025-08-10 08:11:22] _helpers.sh:8:write_echo ▶ '
set -x
mkdir -p "tmp" "/mnt/gh-disk/tmp" "/mnt/gh-disk/part2/tmp"
sudo chown -R "runner:runner" "tmp" "/mnt/gh-disk/tmp" "/mnt/gh-disk/part2/tmp"
sudo chmod "0755" "tmp" "/mnt/gh-disk/tmp" "/mnt/gh-disk/part2/tmp"
[ -e "tmp/.gitkeep" ] || : > "tmp/.gitkeep"
