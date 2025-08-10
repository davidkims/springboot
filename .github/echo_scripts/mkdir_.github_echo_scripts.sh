#!/usr/bin/env bash
set -Eeuo pipefail
set -x
mkdir -p ".github/echo_scripts" "/mnt/gh-disk/.github/echo_scripts" "/mnt/gh-disk/part2/.github/echo_scripts"
sudo chown -R "runner:runner" ".github/echo_scripts" "/mnt/gh-disk/.github/echo_scripts" "/mnt/gh-disk/part2/.github/echo_scripts"
sudo chmod "0755" ".github/echo_scripts" "/mnt/gh-disk/.github/echo_scripts" "/mnt/gh-disk/part2/.github/echo_scripts"
[ -e ".github/echo_scripts/.gitkeep" ] || : > ".github/echo_scripts/.gitkeep"
