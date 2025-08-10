#!/usr/bin/env bash
set -Eeuo pipefail
export PS4='+ [2025-08-10 07:45:50] _helpers.sh:9:write_echo ▶ '
set -x
CUR_BYTES=$(stat -c%s "disk.img")
CUR_MB=$(( (CUR_BYTES + 1024*1024 - 1) / (1024*1024) ))
NEW_MB=1024
[[ $NEW_MB -gt $CUR_MB ]] && truncate -s ${NEW_MB}M "disk.img" || true
LOOP_DEV=$(sudo losetup -j disk.img | awk -F: '{print $1}')
sudo losetup -c "${LOOP_DEV}"
"sudo
resize2fs
\"${LOOP_DEV}\""
