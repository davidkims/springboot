#!/usr/bin/env bash
set -Eeuo pipefail
set -x
mkdir -p "data" "/mnt/gh-disk/data" "/mnt/gh-disk/part2/data"
sudo chown -R "runner:runner" "data" "/mnt/gh-disk/data" "/mnt/gh-disk/part2/data"
sudo chmod "0755" "data" "/mnt/gh-disk/data" "/mnt/gh-disk/part2/data"
[ -e "data/.gitkeep" ] || : > "data/.gitkeep"
