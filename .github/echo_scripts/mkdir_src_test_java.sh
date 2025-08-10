#!/usr/bin/env bash
set -Eeuo pipefail
export PS4='+ [2025-08-10 07:46:52] _helpers.sh:9:write_echo ▶ '
set -x
mkdir -p "src/test/java" "/mnt/gh-disk/src/test/java"
sudo chown -R "runner:runner" "src/test/java" "/mnt/gh-disk/src/test/java"
sudo chmod "0755" "src/test/java" "/mnt/gh-disk/src/test/java"
[ -e "src/test/java/.gitkeep" ] || : > "src/test/java/.gitkeep"
