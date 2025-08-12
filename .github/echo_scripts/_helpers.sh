#!/usr/bin/env bash
set -Eeuo pipefail
MNT_DEFAULT="/mnt/gh-disk"
default_mount()      { echo "${INPUT_MOUNT_POINT:-$MNT_DEFAULT}"; }
default_fs()         { echo "${INPUT_FS_TYPE:-ext4}"; }
default_dir_mode()   { echo "${INPUT_DIR_MODE:-0755}"; }
default_dir_list()   { echo "${INPUT_DIR_LIST:-logs,tmp,backup,data,site,.github/echo_logs,.github/echo_scripts}"; }
default_bulk_spec()  { echo "${INPUT_BULK_SPEC:-dirs=100,files=10,size_kb=4,prefix=gen}"; }
parse_owner_group(){ local og="${1:-runner:runner}"; echo "${og%%:*} ${og#*:}"; }
get_loop(){
  local dev; dev="$(sudo losetup -j "$DISK_IMG" | awk -F: '{print $1}')" || dev=""
  if [[ -z "$dev" ]]; then sudo losetup -fP "$DISK_IMG"; dev="$(sudo losetup -j "$DISK_IMG" | awk -F: '{print $1}')" || dev=""; fi
  [[ -z "$dev" ]] && { echo "[ERROR] loop device not found for $DISK_IMG" >&2; return 1; }
  printf "%s" "$dev"
}
retry_mount(){
  local dev="$1" target="$2"
  sudo install -d -m 0755 "$target"
  for i in 1 2 3; do
    sudo mount "$dev" "$target" && return 0 || true
    sleep 1
  done
  echo "[ERROR] mount $dev -> $target failed" >&2; return 1
}
