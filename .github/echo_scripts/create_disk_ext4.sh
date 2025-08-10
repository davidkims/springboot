#!/usr/bin/env bash
set -Eeuo pipefail
export PS4='+ [2025-08-10 07:38:31] _helpers.sh:9:write_echo ▶ '
set -x
dd if=/dev/zero of="disk.img" bs=1M count=0 seek="1024"
sudo mkfs.ext4 '-f' "disk.img"
ls -lh "disk.img"
