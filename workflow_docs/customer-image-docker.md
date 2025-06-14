# 🧾 고객 명함 생성 + 암호화 + 복호화 + 비교 자동화 (echo 완전 적용)

Source: `.github/workflows/customer-image-docker.yml`

**Triggers**: push, workflow_dispatch

## Steps
- 📥 코드 체크아웃
- 📁 디렉토리 및 로고 생성
- 🐍 명함 생성 및 암복호화 Python 스크립트 작성 (echo)
- 🛠️ Docker 이미지 빌드
- 🏃 Docker 실행
- 📂 결과 확인
- 📤 아티팩트 업로드:암호화 명함
- 📤 아티팩트 업로드:복호화 명함
- 📤 아티팩트 업로드:이미지 비교 결과
