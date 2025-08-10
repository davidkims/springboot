#!/usr/bin/env bash
set -Eeuo pipefail
export PS4='+ [$(date "+%F %T")] ${BASH_SOURCE##*/}:${LINENO}:${FUNCNAME[0]:-main} ▶ '
set -x
run_cmd() { echo "[CMD] $*"; eval "$@"; }
get_loop() { local dev; dev="$(sudo losetup -j "$DISK_IMG" | awk -F: '{print $1}')" || dev=""; if [[ -z "$dev" ]]; then sudo losetup -fP "$DISK_IMG"; dev="$(sudo losetup -j "$DISK_IMG" | awk -F: '{print $1}')" || dev=""; fi; [[ -z "$dev" ]] && { echo "[ERROR] loop device not found for $DISK_IMG" >&2; return 1; }; printf "%s" "$dev"; }
parse_owner_group(){ local og="$1"; local u="${og%%:*}"; local g="${og#*:}"; echo "$u" "$g"; }
write_echo() { local target="$1"; shift; mkdir -p "$(dirname "$target")"; { echo "#!/usr/bin/env bash"; echo "set -Eeuo pipefail"; echo "export PS4='+ [$(date "+%F %T")] ${BASH_SOURCE##*/}:${LINENO}:${FUNCNAME[0]:-main} ▶ '"; echo "set -x"; for line in "$@"; do echo "$line"; done; } > "$target"; chmod +x "$target"; echo "[ECHO] Wrote echo script: $target"; }
