#!/usr/bin/env bash
set -euo pipefail

message="${ECHO_MESSAGE:-Finance app started}"
echo "$message"
mkdir -p /logs
echo "$message" >> /logs/start.log
# Placeholder for the actual application logic
exec tail -f /dev/null
