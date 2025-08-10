#!/usr/bin/env bash
set -Eeuo pipefail
export PS4='+ [2025-08-10 08:30:48] _helpers.sh:8:write_echo ▶ '
set -x
mkdir -p "backup" "/mnt/gh-disk/backup" "/mnt/gh-disk/part2/backup"
sudo chown -R "runner:runner" "backup" "/mnt/gh-disk/backup" "/mnt/gh-disk/part2/backup"
sudo chmod "0755" "backup" "/mnt/gh-disk/backup" "/mnt/gh-disk/part2/backup"
[ -e "backup/.gitkeep" ] || : > "backup/.gitkeep"
