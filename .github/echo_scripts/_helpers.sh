#!/usr/bin/env bash
set -Eeuo pipefail
export PS4='+ [$(date "+%F %T")] ${BASH_SOURCE##*/}:${LINENO}:${FUNCNAME[0]:-main} ▶ '
set -x
run_cmd() { echo "[CMD] $*"; eval "$@"; }
write_echo() {
  local target="$1"; shift
  mkdir -p "$(dirname "$target")"
  { echo "#!/usr/bin/env bash"; echo "set -Eeuo pipefail"; echo "export PS4='+ [$(date "+%F %T")] ${BASH_SOURCE##*/}:${LINENO}:${FUNCNAME[0]:-main} ▶ '"; echo "set -x"; for line in "$@"; do echo "$line"; done; } > "$target"
  chmod +x "$target"; echo "[ECHO] Wrote echo script: $target"
}
