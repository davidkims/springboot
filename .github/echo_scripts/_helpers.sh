#!/usr/bin/env bash
set -Eeuo pipefail
export PS4='+ [$(date "+%F %T")] ${BASH_SOURCE##*/}:${LINENO}:${FUNCNAME[0]:-main} ▶ '
set -x
run_cmd() { echo "[CMD] $*"; eval "$@"; }
# Idempotent loop device fetch/attach
get_loop() {
  local dev
  dev="$(sudo losetup -j "$DISK_IMG" | awk -F: '{print $1}')" || dev=""
  if [[ -z "${dev}" ]]; then
    sudo losetup -fP "$DISK_IMG"
    dev="$(sudo losetup -j "$DISK_IMG" | awk -F: '{print $1}')" || dev=""
  fi
  [[ -z "${dev}" ]] && { echo "[ERROR] loop device not found for $DISK_IMG" >&2; return 1; }
  printf "%s" "$dev"
}
parse_owner_group() {
  local og="${1:-runner:runner}"
  local u="${og%%:*}"
  local g="${og#*:}"
  [[ -z "$u" ]] && u="runner"
  [[ -z "$g" ]] && g="runner"
  echo "$u" "$g"
}
# Safe defaults when workflow_dispatch inputs are empty (e.g. on schedule)
default_mount()      { echo "${INPUT_MOUNT_POINT:-/mnt/gh-disk}"; }
default_fs()         { echo "${INPUT_FS_TYPE:-ext4}"; }
default_dir_mode()   { echo "${INPUT_DIR_MODE:-0755}"; }
default_dir_list()   { echo "${INPUT_DIR_LIST:-logs,tmp,backup,data,site,.github/echo_logs,.github/echo_scripts}"; }
default_bulk_spec()  { echo "${INPUT_BULK_SPEC:-dirs=100,files=10,size_kb=4,prefix=gen}"; }
