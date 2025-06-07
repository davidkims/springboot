# 코드 설명 블로그

생성 시각: 2025-06-07 08:31:27

GitHub Actions를 통해 자동 생성된 현재 코드 베이스 요약입니다.

## 파일: `./README.md` (632 lines)

```md
# 🚀 davidkims/springboot 개발 저장소

이 저장소는 Spring Boot 기반의 애플리케이션 개발 예제 및 관련 워크플로우를 포함합니다.
아래 내용은 GitHub Actions 워크플로우에 의해 자동으로 생성 및 관리됩니다.

```

## 파일: `./rust-example/Cargo.toml` (6 lines)

```toml
[package]
name = "rust-example"
version = "0.1.0"
edition = "2024"

```

## 파일: `./rust-example/src/main.rs` (3 lines)

```rs
fn main() {
    println!("Hello, world!");
}
```

## 파일: `./scripts/db_setup_and_backup.sh` (75 lines)

```sh
#!/usr/bin/env bash
set -euxo pipefail

# ─── 환경 변수 (필요 시 오버라이드 가능) ───────────────────────────────────────
: "${MYSQL_ROOT_PASSWORD:=rootpass123}"
```

## 파일: `./scripts/generate_blog.py` (48 lines)

```py
import os
from datetime import datetime

EXCLUDE_DIRS = {'.git', '.github'}
EXTENSIONS = {'.py', '.sh', '.rs', '.yml', '.yaml', '.toml', '.md'}
```

## 파일: `./scripts/install_rust.sh` (14 lines)

```sh
#!/usr/bin/env bash
set -euo pipefail

# Install Rust using rustup with default toolchain and no prompts
curl https://sh.rustup.rs -sSf | sh -s -- -y
```

## 파일: `./scripts/optimize_disk.sh` (51 lines)

```sh
#!/bin/bash
# optimize_disk.sh - Manage disk usage for given directories.
# Usage: optimize_disk.sh DIR [DIR...]
# Creates backups and removes old files if disk usage exceeds threshold.

```

