#!/usr/bin/env bash
set -Eeuo pipefail
export PS4='+ [2025-08-10 07:46:52] _helpers.sh:9:write_echo ▶ '
set -x
mkdir -p ".github/echo_scripts" "/mnt/gh-disk/.github/echo_scripts"
sudo chown -R "runner:runner" ".github/echo_scripts" "/mnt/gh-disk/.github/echo_scripts"
sudo chmod "0755" ".github/echo_scripts" "/mnt/gh-disk/.github/echo_scripts"
[ -e ".github/echo_scripts/.gitkeep" ] || : > ".github/echo_scripts/.gitkeep"
