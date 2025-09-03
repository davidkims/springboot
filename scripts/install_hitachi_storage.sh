#!/usr/bin/env bash
set -euo pipefail

# Parameters allow customization but default to large-scale installation
SIZE=${HITACHI_STORAGE_SIZE:-large}
RELEASE=${HITACHI_STORAGE_RELEASE:-latest}

echo "[Hitachi Storage] Starting ${SIZE} installation for release ${RELEASE}."

# Update package index and install hypothetical Hitachi CLI
sudo apt-get update -y
sudo apt-get install -y hitachi-storage-cli

# Execute bulk installation using the CLI
hitachi-storage-cli install --mode bulk --size "$SIZE" --release "$RELEASE"

echo "[Hitachi Storage] Installation complete."
