#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Install Docker and build/run finance_app container
"${SCRIPT_DIR}/setup_finance_docker.sh"

# Install MySQL/PostgreSQL and create databases
"${SCRIPT_DIR}/db_setup_and_backup.sh"

# Generate bulk transactions for Shinhan Bank sample
"${SCRIPT_DIR}/generate_shinhan_transactions.sh"

echo "Finance workflow completed."
