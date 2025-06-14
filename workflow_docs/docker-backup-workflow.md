# 🐳 Docker Finance Backup with GHCR + Kafka-style Logging

Source: `.github/workflows/docker-backup-workflow.yml`

**Triggers**: workflow_dispatch, schedule

## Steps
- 📁 Checkout Repository
- 🛠️ Dockerfile 생성 (가상 거래 시뮬레이션 포함)
- 🔐 Docker 로그인 (GHCR)
- 🏗️ Docker 이미지 빌드 및 푸시
- 📦 Docker 볼륨 생성
- 🚀 컨테이너 실행 (거래 수행 및 백업 적재)
- 📂 볼륨 내 백업 확인
- 📄 Kafka-style 로그 출력
