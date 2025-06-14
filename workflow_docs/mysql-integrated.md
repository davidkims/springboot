# MySQL 설정, 마이그레이션 및 백업

Source: `.github/workflows/mysql-integrated.yml`

**Triggers**: workflow_dispatch

## Steps
- 📁 마이그레이션 디렉토리 생성 및 SQL 파일 준비
- 🧪 MySQL 서버 설치
- 🧼 MySQL 안전 모드 및 루트 비밀번호 설정
- 🛠️ 데이터베이스 및 사용자 생성
- 📥 마이그레이션 실행
- ✅ 데이터 확인
- 🕒 타임스탬프 및 동적 포트 생성
- 🐳 MySQL 백업 컨테이너 실행
- 🔐 보안 MySQL 로그인 파일(.my.cnf) 생성
- 📁 백업 디렉토리 생성
- 💾 mysqldump 백업 실행
- 🔍 컨테이너 정보 인쇄
