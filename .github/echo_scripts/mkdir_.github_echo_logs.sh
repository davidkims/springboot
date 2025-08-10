#!/usr/bin/env bash
set -Eeuo pipefail
export PS4='+ [2025-08-10 08:11:21] _helpers.sh:8:write_echo ▶ '
set -x
mkdir -p ".github/echo_logs" "/mnt/gh-disk/.github/echo_logs" "/mnt/gh-disk/part2/.github/echo_logs"
sudo chown -R "runner:runner" ".github/echo_logs" "/mnt/gh-disk/.github/echo_logs" "/mnt/gh-disk/part2/.github/echo_logs"
sudo chmod "0755" ".github/echo_logs" "/mnt/gh-disk/.github/echo_logs" "/mnt/gh-disk/part2/.github/echo_logs"
[ -e ".github/echo_logs/.gitkeep" ] || : > ".github/echo_logs/.gitkeep"
