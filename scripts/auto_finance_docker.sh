#!/usr/bin/env bash
set -euo pipefail

IMAGE_NAME="finance_app_echo:latest"
CONTAINER_PREFIX="finance_echo"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
APP_DIR="${SCRIPT_DIR}/../finance_app"
LOG_DIR="${SCRIPT_DIR}/../logs"

build_image() {
  docker build -t "$IMAGE_NAME" "$APP_DIR"
}

create_container() {
  local index="$1"
  local name="${CONTAINER_PREFIX}_${index}"
  local container_log="${LOG_DIR}/${name}"
  mkdir -p "$container_log"
  if docker ps -a --format '{{.Names}}' | grep -q "^${name}$"; then
    docker rm -f "$name"
  fi
  docker run -d --name "$name" -e ECHO_MESSAGE="Finance container ${index} started" -v "$container_log:/logs" "$IMAGE_NAME"
}

create_containers() {
  local count="$1"
  for i in $(seq 1 "$count"); do
    create_container "$i"
  done
}

main() {
  local count="${1:-3}"
  build_image
  create_containers "$count"
  echo "Launched ${count} finance containers with echo capability."
}

main "$@"
