#!/usr/bin/env bash
set -euo pipefail

# Defaults (override with environment variables)
: "${REPO_DIR:=.}"
: "${CONTAINER_NAME:=my-nginx}"
: "${IMAGE:=nginx:latest}"
: "${DATA_DIR:=docker_data}"
: "${DISK_FILE:=docker_data/disk.img}"

rollback() {
  echo "Error occurred. Rolling back..."
  if [ -d "${REPO_DIR}/.github.bak" ]; then
    rm -rf "${REPO_DIR}/.github"
    mv "${REPO_DIR}/.github.bak" "${REPO_DIR}/.github"
  fi
  if sudo docker ps -a --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
    sudo docker rm -f "${CONTAINER_NAME}" || true
  fi
  if [ -f "${DISK_FILE}" ]; then
    rm -f "${DISK_FILE}"
  fi
}

trap rollback ERR

backup() {
  if [ -d "${REPO_DIR}/.github" ]; then
    rm -rf "${REPO_DIR}/.github.bak"
    cp -r "${REPO_DIR}/.github" "${REPO_DIR}/.github.bak"
  fi
}

clean() {
  sudo docker rm -f "${CONTAINER_NAME}" 2>/dev/null || true
  sudo docker rmi "${IMAGE}" 2>/dev/null || true
  rm -rf "${DATA_DIR}" "${REPO_DIR}/.github"
}

install() {
  git checkout -- .github
  ./scripts/setup_docker_environment.sh
}

main() {
  backup
  clean
  install
  rm -rf "${REPO_DIR}/.github.bak"
  echo "Setup complete"
}

main "$@"
