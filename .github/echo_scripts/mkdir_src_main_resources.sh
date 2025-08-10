#!/usr/bin/env bash
set -Eeuo pipefail
set -x
mkdir -p "src/main/resources" "/mnt/gh-disk/src/main/resources" "/mnt/gh-disk/part2/src/main/resources"
sudo chown -R "runner:runner" "src/main/resources" "/mnt/gh-disk/src/main/resources" "/mnt/gh-disk/part2/src/main/resources"
sudo chmod "0755" "src/main/resources" "/mnt/gh-disk/src/main/resources" "/mnt/gh-disk/part2/src/main/resources"
[ -e "src/main/resources/.gitkeep" ] || : > "src/main/resources/.gitkeep"
