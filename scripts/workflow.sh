#!/usr/bin/env bash
set -euo pipefail

# Install Rust if cargo is not available
if ! command -v cargo >/dev/null 2>&1; then
  curl https://sh.rustup.rs -sSf | sh -s -- -y
  if [ -f "$HOME/.cargo/env" ]; then
    source "$HOME/.cargo/env"
  fi
fi

# Prepare directories
mkdir -p workflow/{system,disk,container,image}

# Base files
echo "시스템 설정" > workflow/system/system.conf
echo "디스크 정보" > workflow/disk/disk.info
echo "컨테이너 설정" > workflow/container/container.conf
echo "이미지 메타" > workflow/image/image.meta

# Bulk file creation
for i in {1..10}; do
  echo "시스템 설정 $i" > workflow/system/config$i.conf
  echo "디스크 정보 $i" > workflow/disk/disk$i.info
  echo "컨테이너 설정 $i" > workflow/container/ctr$i.conf
  echo "이미지 메타 $i" > workflow/image/img$i.meta
done

# Build and run Rust project to generate additional files
(
  cd rust-example
  cargo build --release
  cargo run --release
)
