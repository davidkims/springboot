#!/usr/bin/env bash
set -Eeuo pipefail
export PS4='+ [2025-08-10 07:38:31] _helpers.sh:9:write_echo ▶ '
set -x
echo -e "\n# auto-generated\ndisk.img\n*.img\n.github/echo_logs/*.log\n" >> .gitignore
