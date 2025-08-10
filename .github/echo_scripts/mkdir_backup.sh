#!/usr/bin/env bash
set -Eeuo pipefail
export PS4='+ [2025-08-10 07:38:31] _helpers.sh:9:write_echo ▶ '
set -x
mkdir -p "/mnt/gh-disk/backup" "./backup"
sudo chown -R "runner:runner" "/mnt/gh-disk/backup" "./backup"
sudo chmod "0755" "/mnt/gh-disk/backup" "./backup"
