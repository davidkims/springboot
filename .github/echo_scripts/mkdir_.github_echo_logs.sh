#!/usr/bin/env bash
set -Eeuo pipefail
export PS4='+ [2025-08-10 07:46:52] _helpers.sh:9:write_echo ▶ '
set -x
mkdir -p ".github/echo_logs" "/mnt/gh-disk/.github/echo_logs"
sudo chown -R "runner:runner" ".github/echo_logs" "/mnt/gh-disk/.github/echo_logs"
sudo chmod "0755" ".github/echo_logs" "/mnt/gh-disk/.github/echo_logs"
[ -e ".github/echo_logs/.gitkeep" ] || : > ".github/echo_logs/.gitkeep"
