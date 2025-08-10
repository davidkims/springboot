#!/usr/bin/env bash
set -Eeuo pipefail
export PS4='+ [2025-08-10 07:46:52] _helpers.sh:9:write_echo ▶ '
set -x
mkdir -p "site" "/mnt/gh-disk/site"
sudo chown -R "runner:runner" "site" "/mnt/gh-disk/site"
sudo chmod "0755" "site" "/mnt/gh-disk/site"
[ -e "site/.gitkeep" ] || : > "site/.gitkeep"
