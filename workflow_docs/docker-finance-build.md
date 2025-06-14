# 🔐 금융 거래 자동 백업

Source: `.github/workflows/docker-finance-build.yml`

**Triggers**: push, schedule, workflow_dispatch

## Steps
- 📂 저장소 체크아웃
- 📁 백업 디렉토리 생성
- 📜 Dockerfile 자동 생성
- 📝 금융 스키마 작성
- 🐋 Docker 이미지 빌드
- 🚀 MySQL 컨테이너 시작 및 대기
- 💾 SQL 백업 실행
- 🧹 컨테이너 정리
