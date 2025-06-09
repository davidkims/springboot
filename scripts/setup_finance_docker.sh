#!/usr/bin/env bash
set -euo pipefail

IMAGE_NAME="finance_app:v1"
CONTAINER_NAME="finance_container"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
BACKUP_SCRIPT="${SCRIPT_DIR}/docker_backup.sh"
CRON_FILE="/etc/cron.d/finance_backup"

install_docker() {
  if ! command -v docker >/dev/null 2>&1; then
    echo "Installing Docker..."
    sudo apt-get update
    sudo apt-get install -y docker.io
    sudo systemctl enable --now docker || sudo service docker start
  else
    echo "Docker already installed"
  fi
}

build_image() {
  echo "Building Docker image ${IMAGE_NAME}"
  sudo docker build -t "$IMAGE_NAME" "${SCRIPT_DIR}/../finance_app"
}

run_container() {
  if sudo docker ps --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
    echo "Container ${CONTAINER_NAME} already running"
  else
    if sudo docker ps -a --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
      sudo docker rm "$CONTAINER_NAME"
    fi
    echo "Starting container ${CONTAINER_NAME}"
    sudo docker run -d --name "$CONTAINER_NAME" "$IMAGE_NAME"
  fi
}

setup_cron() {
  sudo mkdir -p /var/backups/docker_finance
  local cron_entry="0 * * * * root ${BACKUP_SCRIPT}"
  echo "$cron_entry" | sudo tee "$CRON_FILE" >/dev/null
  sudo chmod 644 "$CRON_FILE"
  sudo systemctl reload cron || sudo service cron reload
}

main() {
  install_docker
  build_image
  run_container
  setup_cron
  echo "Setup completed. Backups will run hourly."
}

main "$@"
