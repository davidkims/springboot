#!/usr/bin/env bash
set -Eeuo pipefail
export PS4='+ [2025-08-10 08:11:22] _helpers.sh:8:write_echo ▶ '
set -x
mkdir -p "src/main/java" "/mnt/gh-disk/src/main/java" "/mnt/gh-disk/part2/src/main/java"
sudo chown -R "runner:runner" "src/main/java" "/mnt/gh-disk/src/main/java" "/mnt/gh-disk/part2/src/main/java"
sudo chmod "0755" "src/main/java" "/mnt/gh-disk/src/main/java" "/mnt/gh-disk/part2/src/main/java"
[ -e "src/main/java/.gitkeep" ] || : > "src/main/java/.gitkeep"
