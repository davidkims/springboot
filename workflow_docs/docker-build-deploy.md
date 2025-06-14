# Build & Deploy finance-transactions

Source: `.github/workflows/docker-build-deploy.yml`

**Triggers**: workflow_dispatch

## Steps
- Checkout 코드
- Docker 설치 및 서비스 시작
- finance-transactions 이미지 빌드
- finance-transactions 컨테이너 재시작
- Run full setup script
- 컨테이너 정리
