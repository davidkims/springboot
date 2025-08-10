#!/usr/bin/env bash
set -Eeuo pipefail
set -x
echo -e "\n# auto-generated\ndisk.img\n*.img\n.github/echo_logs/*.log\n" >> .gitignore
