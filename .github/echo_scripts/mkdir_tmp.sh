#!/usr/bin/env bash
set -Eeuo pipefail
set -x
mkdir -p "tmp" "/mnt/gh-disk/tmp" "/mnt/gh-disk/part2/tmp"
sudo chown -R "runner:runner" "tmp" "/mnt/gh-disk/tmp" "/mnt/gh-disk/part2/tmp"
sudo chmod "0755" "tmp" "/mnt/gh-disk/tmp" "/mnt/gh-disk/part2/tmp"
[ -e "tmp/.gitkeep" ] || : > "tmp/.gitkeep"
