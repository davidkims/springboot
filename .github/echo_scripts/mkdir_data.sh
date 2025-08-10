#!/usr/bin/env bash
set -Eeuo pipefail
export PS4='+ [2025-08-10 07:46:52] _helpers.sh:9:write_echo ▶ '
set -x
mkdir -p "data" "/mnt/gh-disk/data"
sudo chown -R "runner:runner" "data" "/mnt/gh-disk/data"
sudo chmod "0755" "data" "/mnt/gh-disk/data"
[ -e "data/.gitkeep" ] || : > "data/.gitkeep"
