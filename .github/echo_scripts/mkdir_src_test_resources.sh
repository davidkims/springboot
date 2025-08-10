#!/usr/bin/env bash
set -Eeuo pipefail
export PS4='+ [2025-08-10 07:46:52] _helpers.sh:9:write_echo ▶ '
set -x
mkdir -p "src/test/resources" "/mnt/gh-disk/src/test/resources"
sudo chown -R "runner:runner" "src/test/resources" "/mnt/gh-disk/src/test/resources"
sudo chmod "0755" "src/test/resources" "/mnt/gh-disk/src/test/resources"
[ -e "src/test/resources/.gitkeep" ] || : > "src/test/resources/.gitkeep"
