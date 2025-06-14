# 💳 카드사별 거래 백업 + NetBackup + OCI 업로드

Source: `.github/workflows/swift-backup.yml`

**Triggers**: workflow_dispatch, push

## Steps
- 📁 저장소 체크아웃
- 🧰 Swift 설치
- 🧾 카드사별 거래 파일 생성 (텍스트 형식)
- 🗜️ ZIP 압축
- ☁️ Oracle OCI CLI 설치
- ☁️ 카드사별 거래 파일 OCI 업로드
- 🧱 NetBackup CLI 설치 및 bpbackup 실행
- 📊 최종 보고서
