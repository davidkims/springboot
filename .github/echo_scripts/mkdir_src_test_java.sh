#!/usr/bin/env bash
set -Eeuo pipefail
set -x
mkdir -p "src/test/java" "/mnt/gh-disk/src/test/java" "/mnt/gh-disk/part2/src/test/java"
sudo chown -R "runner:runner" "src/test/java" "/mnt/gh-disk/src/test/java" "/mnt/gh-disk/part2/src/test/java"
sudo chmod "0755" "src/test/java" "/mnt/gh-disk/src/test/java" "/mnt/gh-disk/part2/src/test/java"
[ -e "src/test/java/.gitkeep" ] || : > "src/test/java/.gitkeep"
