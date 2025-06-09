#!/usr/bin/env bash
set -euo pipefail

BACKUP_DIR="/var/backups/docker_finance"
DATE=$(date +'%Y%m%d%H')

mkdir -p "$BACKUP_DIR"

sudo docker save finance_app:v1 > "$BACKUP_DIR/finance_app_v1_${DATE}.tar"

if sudo docker ps -a --format '{{.Names}}' | grep -q '^finance_container$'; then
  sudo docker container commit finance_container finance_container_backup:v1
  sudo docker save finance_container_backup:v1 > "$BACKUP_DIR/finance_container_backup_v1_${DATE}.tar"
  sudo docker rmi finance_container_backup:v1
fi
