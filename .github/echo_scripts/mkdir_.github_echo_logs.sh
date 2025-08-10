#!/usr/bin/env bash
set -Eeuo pipefail
set -x
mkdir -p ".github/echo_logs" "/mnt/gh-disk/.github/echo_logs" "/mnt/gh-disk/part2/.github/echo_logs"
sudo chown -R "runner:runner" ".github/echo_logs" "/mnt/gh-disk/.github/echo_logs" "/mnt/gh-disk/part2/.github/echo_logs"
sudo chmod "0755" ".github/echo_logs" "/mnt/gh-disk/.github/echo_logs" "/mnt/gh-disk/part2/.github/echo_logs"
[ -e ".github/echo_logs/.gitkeep" ] || : > ".github/echo_logs/.gitkeep"
