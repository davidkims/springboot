#!/usr/bin/env bash
set -Eeuo pipefail
export PS4='+ [2025-08-10 08:30:48] _helpers.sh:8:write_echo ▶ '
set -x
mkdir -p "site" "/mnt/gh-disk/site" "/mnt/gh-disk/part2/site"
sudo chown -R "runner:runner" "site" "/mnt/gh-disk/site" "/mnt/gh-disk/part2/site"
sudo chmod "0755" "site" "/mnt/gh-disk/site" "/mnt/gh-disk/part2/site"
[ -e "site/.gitkeep" ] || : > "site/.gitkeep"
