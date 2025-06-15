# 🧾 금융 거래 자동화 (PDF 영수증 포함)

Source: `.github/workflows/retrigger-and-db-init.yml`

**Triggers**: workflow_dispatch, push

## Steps
- 📥 저장소 체크아웃
- 📁 echo 기반 코드 파일 및 디렉토리 생성
- 🛠️ Docker Compose Build & Start
- 📤 거래 CSV 업로드
- 📤 성공 영수증 PDF 업로드
