#!/usr/bin/env bash
set -Eeuo pipefail
export PS4='+ [2025-08-10 07:46:52] _helpers.sh:9:write_echo ▶ '
set -x
mkdir -p "src/main/resources" "/mnt/gh-disk/src/main/resources"
sudo chown -R "runner:runner" "src/main/resources" "/mnt/gh-disk/src/main/resources"
sudo chmod "0755" "src/main/resources" "/mnt/gh-disk/src/main/resources"
[ -e "src/main/resources/.gitkeep" ] || : > "src/main/resources/.gitkeep"
