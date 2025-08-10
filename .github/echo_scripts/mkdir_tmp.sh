#!/usr/bin/env bash
set -Eeuo pipefail
export PS4='+ [2025-08-10 07:46:53] _helpers.sh:9:write_echo ▶ '
set -x
mkdir -p "tmp" "/mnt/gh-disk/tmp"
sudo chown -R "runner:runner" "tmp" "/mnt/gh-disk/tmp"
sudo chmod "0755" "tmp" "/mnt/gh-disk/tmp"
[ -e "tmp/.gitkeep" ] || : > "tmp/.gitkeep"
