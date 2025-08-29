#!/usr/bin/env bash
set -Eeuo pipefail

echoe(){ echo "[ECHO] $*"; }
warn(){ echo "[ECHO][WARN] $*" >&2; }
faile(){ echo "[ECHO][FAIL] $*" >&2; exit 1; }
have(){ command -v "$1" >/dev/null 2>&1; }
retry(){ local t="$1"; shift; local s="$1"; shift; local n=0; until "$@"; do n=$((n+1)); [ "$n" -ge "$t" ] && return 1; sleep "$s"; done; }

wait_http(){ local url="$1"; local max="${2:-60}"; local i=0; while true; do curl -fsS --max-time 3 "$url" >/dev/null 2>&1 && return 0; i=$((i+1)); [ "$i" -ge "$max" ] && return 1; sleep 1; done; }

ensure_podman(){
  sudo apt-get update -y
  sudo apt-get install -y --no-install-recommends podman podman-docker slirp4netns uidmap containernetworking-plugins
  have podman || faile "podman not installed"
  podman info >/dev/null 2>&1 || true
}

resolve(){
  DOCKER_BIN="$(command -v /usr/bin/docker || command -v docker || true)"
  PODMAN_BIN="$(command -v podman || true)"
  export DOCKER_BIN PODMAN_BIN
}

ctr(){
  if [ "${USE_PODMAN:-0}" = "1" ]; then
    [ -n "${PODMAN_BIN:-}" ] || faile "podman not available"
    "$PODMAN_BIN" "$@"
  else
    [ -n "${DOCKER_BIN:-}" ] || faile "docker not available"
    "$DOCKER_BIN" "$@"
  fi
}

start_docker(){
  resolve
  if [ -n "${DOCKER_BIN:-}" ]; then
    set +e; "$DOCKER_BIN" info >/dev/null 2>&1; rc=$?; set -e
    if [ $rc -eq 0 ]; then USE_PODMAN=0; export USE_PODMAN; echoe "engine=docker"; return; fi
    command -v service >/dev/null 2>&1 && { set +e; sudo service docker start >/dev/null 2>&1; "$DOCKER_BIN" info >/dev/null 2>&1 && { USE_PODMAN=0; export USE_PODMAN; echoe "engine=docker"; return; }; set -e; }
  fi
  ensure_podman
  resolve
  USE_PODMAN=1; export USE_PODMAN; echoe "engine=podman"
}

install_awscli(){
  if have aws; then echoe "awscli: $(aws --version 2>&1)"; return; fi
  sudo apt-get update -y
  sudo apt-get install -y awscli || {
    echoe "awscli APT not found, installing via pip"
    python3 -m pip install --upgrade --user pip >/dev/null 2>&1 || true
    python3 -m pip install --user awscli || warn "awscli pip install failed (non-fatal)"
    [ -d "$HOME/.local/bin" ] && echo "$HOME/.local/bin" >> "$GITHUB_PATH"
  }
}

install_s3fs(){
  if have s3fs; then echoe "s3fs present"; return; fi
  sudo apt-get update -y
  sudo apt-get install -y s3fs || sudo apt-get install -y s3fs-fuse || warn "s3fs install failed (non-fatal)"
}

install_gcsfuse(){
  if have gcsfuse; then echoe "gcsfuse present: $(gcsfuse --version 2>/dev/null || echo v2)"; return; fi
  . /etc/os-release
  CODENAME="${UBUNTU_CODENAME:-${VERSION_CODENAME:-}}"
  [ -z "$CODENAME" ] && CODENAME="$(lsb_release -cs 2>/dev/null || echo jammy)"
  REPO_CODENAME="$CODENAME"
  [ "$CODENAME" = "noble" ] && REPO_CODENAME="jammy"
  sudo mkdir -p /usr/share/keyrings
  curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo tee /usr/share/keyrings/cloud.google.gpg >/dev/null
  echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt gcsfuse-${REPO_CODENAME} main" | sudo tee /etc/apt/sources.list.d/gcsfuse.list >/dev/null
  set +e
  sudo apt-get update -y
  sudo apt-get install -y fuse3 gcsfuse
  rc=$?
  set -e
  if [ $rc -ne 0 ]; then
    warn "gcsfuse APT install failed (repo=${REPO_CODENAME}). Trying release binary..."
    tmpdir="$(mktemp -d)"
    url="https://github.com/GoogleCloudPlatform/gcsfuse/releases/latest/download/gcsfuse_linux_amd64.tar.gz"
    if curl -fsSL "$url" -o "${tmpdir}/gcsfuse.tgz"; then
      tar -xzf "${tmpdir}/gcsfuse.tgz" -C "${tmpdir}" || true
      found="$(find "${tmpdir}" -maxdepth 2 -type f -name gcsfuse | head -n1 || true)"
      [ -n "$found" ] && sudo install -m0755 "$found" /usr/local/bin/gcsfuse
    fi
    have gcsfuse || warn "gcsfuse install failed (non-fatal)."
  fi
}

install_blobfuse2(){
  if have blobfuse2; then echoe "blobfuse2 present"; return; fi
  . /etc/os-release
  curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /usr/share/keyrings/microsoft.gpg >/dev/null
  echo "deb [arch=amd64,arm64 signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/ubuntu/${VERSION_ID}/prod ${UBUNTU_CODENAME} main" | sudo tee /etc/apt/sources.list.d/microsoft-prod.list >/dev/null
  sudo apt-get update -y || true
  sudo apt-get install -y fuse3 blobfuse2 || warn "blobfuse2 install failed (non-fatal)"
}
