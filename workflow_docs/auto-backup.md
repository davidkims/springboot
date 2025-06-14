# 🔁 Auto Finance Backup (Manual + Cron)

Source: `.github/workflows/auto-backup.yml`

**Triggers**: workflow_dispatch, schedule

## Steps
- 📁 디렉토리 생성 및 초기 SQL 파일 준비
- 🐬 MySQL 컨테이너 실행
- 🔐 MySQL 로그인 구성 및 백업 실행
- 🧹 MySQL 컨테이너 정리
