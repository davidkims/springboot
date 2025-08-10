#!/usr/bin/env bash
set -Eeuo pipefail
export PS4='+ [2025-08-10 08:11:21] _helpers.sh:8:write_echo ▶ '
set -x
mkdir -p ".github/echo_scripts" "/mnt/gh-disk/.github/echo_scripts" "/mnt/gh-disk/part2/.github/echo_scripts"
sudo chown -R "runner:runner" ".github/echo_scripts" "/mnt/gh-disk/.github/echo_scripts" "/mnt/gh-disk/part2/.github/echo_scripts"
sudo chmod "0755" ".github/echo_scripts" "/mnt/gh-disk/.github/echo_scripts" "/mnt/gh-disk/part2/.github/echo_scripts"
[ -e ".github/echo_scripts/.gitkeep" ] || : > ".github/echo_scripts/.gitkeep"
