#!/bin/bash
set -e

IMAGE_NAME="workflow-image"
CONTAINER_NAME="workflow-container"
VOLUME_PREFIX="data_volume"

# 이미지 빌드
docker build -t "$IMAGE_NAME" .

# 볼륨 10개 생성
for i in {1..10}; do
  docker volume create "${VOLUME_PREFIX}_${i}"
done

# 컨테이너 실행
docker run -d \
  --name "$CONTAINER_NAME" \
  -v "${VOLUME_PREFIX}_1:/data" \
  "$IMAGE_NAME"

echo "[automation] 컨테이너와 볼륨 생성 완료"
