#!/usr/bin/env bash
set -Eeuo pipefail
export PS4='+ [2025-08-10 07:43:42] _helpers.sh:9:write_echo ▶ '
set -x
mkdir -p "/mnt/gh-disk/tmp" "./tmp"
sudo chown -R "runner:runner" "/mnt/gh-disk/tmp" "./tmp"
sudo chmod "0755" "/mnt/gh-disk/tmp" "./tmp"
