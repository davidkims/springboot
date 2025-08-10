#!/usr/bin/env bash
set -Eeuo pipefail
export PS4='+ [2025-08-10 07:46:52] _helpers.sh:9:write_echo ▶ '
set -x
mkdir -p "backup" "/mnt/gh-disk/backup"
sudo chown -R "runner:runner" "backup" "/mnt/gh-disk/backup"
sudo chmod "0755" "backup" "/mnt/gh-disk/backup"
[ -e "backup/.gitkeep" ] || : > "backup/.gitkeep"
