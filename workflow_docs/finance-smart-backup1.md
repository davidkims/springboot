# PostgreSQL DB 백업 및 S3 업로드

Source: `.github/workflows/finance-smart-backup1.yml`

**Triggers**: workflow_dispatch

## Steps
- 📦 사전 준비:PostgreSQL 클라이언트 설치
- 🕒 타임스탬프 및 백업 파일 경로 설정
- 💾 PostgreSQL 데이터베이스 백업 (pg_dump)
- 🔐 백업 파일 암호화 (선택 사항)
- ☁️ AWS 자격 증명 구성
- ⬆️ S3에 백업 업로드
- 🧹 로컬 백업 파일 정리
