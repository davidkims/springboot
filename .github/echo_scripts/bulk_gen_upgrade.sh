#!/usr/bin/env bash
set -Eeuo pipefail
export PS4='+ [2025-08-10 08:11:50] _helpers.sh:8:write_echo ▶ '
set -x
SPEC='dirs=100,files=10,size_kb=4,prefix=gen'
getv(){ echo "$SPEC" | tr "," "\n" | awk -F= -v k="$1" '$1==k{print $2}'; }
NUM_DIRS="$(getv dirs)"; NUM_FILES="$(getv files)"; SIZE_KB="$(getv size_kb)"; PREFIX="$(getv prefix)"; : "${NUM_DIRS:=100}"; : "${NUM_FILES:=10}"; : "${SIZE_KB:=4}"; : "${PREFIX:=gen}"
MNT="/mnt/gh-disk"; OWNER="${OWNER}"; GROUP="${GROUP}"; MODE="${MODE}"
ROOT_REPO="bulk/${PREFIX}"; ROOT_P1="${MNT}/bulk/${PREFIX}"; ROOT_P2="${MNT}/part2/bulk/${PREFIX}"
create_or_upgrade_dir() { local base="$1"; local i="$2"; local d="${base}/$(printf "%s-%06d" "$PREFIX" "$i")"; mkdir -p "$d"; for n in $(seq 1 "$NUM_FILES"); do local f="${d}/file-$(printf "%04d" "$n").bin"; if [ -f "$f" ]; then cur="$(stat -c%s "$f" || echo 0)"; need=$(( SIZE_KB * 1024 )); if (( cur < need )); then truncate -s "${need}" "$f"; fi; else truncate -s "$(( SIZE_KB * 1024 ))" "$f"; fi; done; }
for i in $(seq 1 "$NUM_DIRS"); do create_or_upgrade_dir "$ROOT_REPO" "$i"; create_or_upgrade_dir "$ROOT_P1" "$i"; create_or_upgrade_dir "$ROOT_P2" "$i"; done
sudo chown -R "$OWNER:$GROUP" "bulk" "$MNT/bulk" "$MNT/part2/bulk"; sudo chmod -R "$MODE" "bulk" "$MNT/bulk" "$MNT/part2/bulk"
