#!/usr/bin/env bash
set -euo pipefail

# Default variables (can be overridden)
: "${IMAGE:=nginx:latest}"
: "${CONTAINER_NAME:=my-nginx}"
: "${DATA_DIR:=docker_data}"
: "${DISK_FILE:=docker_data/disk.img}"
: "${LOG_FILE:=docker_setup.log}"

install_docker() {
  if ! command -v docker >/dev/null 2>&1; then
    echo "Installing Docker..."
    sudo apt-get update
    sudo apt-get install -y docker.io
  else
    echo "Docker already installed"
  fi

  # Ensure the Docker service is running even when already installed
  if command -v systemctl >/dev/null 2>&1; then
    sudo systemctl start docker || true
  else
    sudo service docker start || true
  fi
}

setup_disk() {
  mkdir -p "$DATA_DIR"
  if [ ! -f "$DISK_FILE" ]; then
    echo "Creating disk file $DISK_FILE"
    sudo fallocate -l 50M "$DISK_FILE" || sudo dd if=/dev/zero of="$DISK_FILE" bs=1M count=50
  fi
  sudo chmod 600 "$DISK_FILE"
}

pull_image() {
  echo "Pulling Docker image $IMAGE"
  sudo docker pull "$IMAGE"
}

run_container() {
  if ! sudo docker ps --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
    if sudo docker ps -a --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
      sudo docker rm "$CONTAINER_NAME"
    fi
    echo "Starting container $CONTAINER_NAME"
    sudo docker run -d --name "$CONTAINER_NAME" -v "$PWD/$DATA_DIR":/usr/share/nginx/html:ro "$IMAGE"
  else
    echo "Container $CONTAINER_NAME already running"
  fi
}

main() {
  {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Starting setup"
    install_docker
    setup_disk
    pull_image
    run_container
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Setup complete"
  } >> "$LOG_FILE" 2>&1
}

main "$@"
