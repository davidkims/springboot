#!/usr/bin/env bash
set -Eeuo pipefail
set -x
mkdir -p "src/test/resources" "/mnt/gh-disk/src/test/resources" "/mnt/gh-disk/part2/src/test/resources"
sudo chown -R "runner:runner" "src/test/resources" "/mnt/gh-disk/src/test/resources" "/mnt/gh-disk/part2/src/test/resources"
sudo chmod "0755" "src/test/resources" "/mnt/gh-disk/src/test/resources" "/mnt/gh-disk/part2/src/test/resources"
[ -e "src/test/resources/.gitkeep" ] || : > "src/test/resources/.gitkeep"
