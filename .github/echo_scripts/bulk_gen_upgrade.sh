#!/usr/bin/env bash
set -Eeuo pipefail
set -x
SPEC='dirs=100,files=10,size_kb=4,prefix=gen'
getv(){
  local key="${1-}"
  [ -z "$key" ] && return 0
  echo "$SPEC" | tr "," "\n" | awk -F= -v k="$key" '$1==k{print $2}'
}
NUM_DIRS="$(getv dirs)"; NUM_FILES="$(getv files)"; SIZE_KB="$(getv size_kb)"; PREFIX="$(getv prefix)"
: "${NUM_DIRS:=100}"; : "${NUM_FILES:=10}"; : "${SIZE_KB:=4}"; : "${PREFIX:=gen}"
MNT="/mnt/gh-disk"; OWNER="runner"; GROUP="runner"; MODE="0755"
ROOT_REPO="bulk/${PREFIX}"; ROOT_P1="${MNT}/bulk/${PREFIX}"; ROOT_P2="${MNT}/part2/bulk/${PREFIX}"

create_or_upgrade_dir() {
  local base="${1-}"
  local i="${2-}"
  [[ -z "$base" || -z "$i" ]] && { echo "[ECHO] create_or_upgrade_dir(): missing args" >&2; return 1; }
  local d="${base}/$(printf '%s-%06d' "$PREFIX" "$i")"
  mkdir -p "$d"
  for n in $(seq 1 "$NUM_FILES"); do
    local f="${d}/file-$(printf '%04d' "$n").bin"
    if [ -f "$f" ]; then
      local cur; cur="$(stat -c%s "$f" || echo 0)"
      local need=$(( SIZE_KB * 1024 ))
      (( cur < need )) && truncate -s "${need}" "$f" || true
    else
      truncate -s "$(( SIZE_KB * 1024 ))" "$f"
    fi
  done
}

for i in $(seq 1 "$NUM_DIRS"); do
  create_or_upgrade_dir "$ROOT_REPO" "$i"
  create_or_upgrade_dir "$ROOT_P1" "$i"
  create_or_upgrade_dir "$ROOT_P2" "$i"
done
sudo chown -R "$OWNER:$GROUP" "bulk" "$MNT/bulk" "$MNT/part2/bulk"
sudo chmod -R "$MODE" "bulk" "$MNT/bulk" "$MNT/part2/bulk"
