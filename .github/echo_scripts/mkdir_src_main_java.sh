#!/usr/bin/env bash
set -Eeuo pipefail
export PS4='+ [2025-08-10 07:46:52] _helpers.sh:9:write_echo ▶ '
set -x
mkdir -p "src/main/java" "/mnt/gh-disk/src/main/java"
sudo chown -R "runner:runner" "src/main/java" "/mnt/gh-disk/src/main/java"
sudo chmod "0755" "src/main/java" "/mnt/gh-disk/src/main/java"
[ -e "src/main/java/.gitkeep" ] || : > "src/main/java/.gitkeep"
