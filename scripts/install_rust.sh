#!/usr/bin/env bash
set -euo pipefail

# Install Rust using rustup with default toolchain and no prompts
curl https://sh.rustup.rs -sSf | sh -s -- -y

# Source cargo environment in current shell (if running interactively)
if [ -f "$HOME/.cargo/env" ]; then
  source "$HOME/.cargo/env"
fi

# Verify installation
rustc --version
cargo --version
