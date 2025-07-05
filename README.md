# 👨‍💻 김병권 포트폴리오

이 리포지토리는 GitHub Actions를 사용하여 자동으로 관리되는 프로젝트입니다.
매 시간마다 이 README는 자동으로 갱신되며 최신 정보를 반영합니다.

## 🧑‍💻 개발자 소개
- 이름: 김병권
- 전문 분야: 백엔드 개발, GitHub Actions 자동화, 보안 자동화, DevOps
- 기술 스택: Python, Java, Spring Boot, FastAPI, Docker, GitHub Actions, PostgreSQL, MySQL
- 이메일: your-email@example.com

## 🛠️ 주요 개발 스킬
- CI/CD 자동화 (GitHub Actions)
- 백엔드 REST API 설계 및 배포
- 보안 점검 자동화 (CodeQL, Scorecard, Bandit, pip-audit 등)
- 로그/백업 자동화 및 스케줄링
- 데이터베이스 마이그레이션 및 백업 관리

## 📅 마지막 업데이트
- 2025-07-05 13:06:27 KST

## ✅ 현재 브랜치
- main

## 🔧 빌드 상태 배지
![Build Status](https://github.com/davidkims/springboot/actions/workflows/update-readme.yml/badge.svg)

## ⚙️ GitHub Actions 워크플로우 목록

- **Provenance with Pages Deploy**:           Copy provenance or fallback
- **Create GitHub Release**: 파일명: .github/workflows/release.yml
- **🧾 Secure Finance Backup (w/ Stable TAR, .github Upload)**: 
- **🧠 Conda Setup & TradingAgents Run**: 
- **🗕️ Airflow Healthcheck DAG Setup & Test**: 
- **🔁 Auto Finance Backup (Manual + Cron)**:   workflow_dispatch:  ✅ 수동 실행 기능 추가됨
- **💰 Generate Bulk Finance Ledger (Manual + Cron)**:     - cron: "*/5 * * * *"  매 5분마다 실행
- **Create GitHub Release**: #전체 워크플로우 코드
- **🧱 Maven Build (echo 버전)**: 
- **Auto Create Workflow File**:     - cron: '0 * * * *'  매시간 정각 실행
- **🧩 Backup + API Speed Check with Gitignore Auto-Fix & Retry**:           echo "Generated: $TIMESTAMP" >> "$OUT_FILE"
- **Project Source Code Backup**: .github/workflows/backup.yml
- **🔄 Finance Smart Backup with PostgreSQL & Kafka**: 
- **키 가가이드 - PDF 영수증 포함**: 
- **♾️ Transfer Log Backup - Cron (60건 Infinite)**: 
- **Project Source Code Backup**: 파일명: .github/workflows/backup.yml
- **🧾 결제 자동화 - PDF 영수증 포함**:           [생략: 기존 ledger.py/Dockerfile/docker-compose.yml echo 내용은 동일하므로 유지됨]
- **💰 Check Workflow Costs with Valid Completed Runs Only**:     - cron: '0 3 * * *'  매일 오전 3시 (KST 정오)
- **✨ Tmax 전체 코드 생성기 및 배포자**:     - cron: '0 3 * * 0'  매주 일요일 3시 실행
- **Codespace Security Configuration Check # 워크플로우의 이름**: name: Codespace Security Configuration Check 워크플로우의 이름
- **🐬 MySQL Root Setup and DB Init**: .github/workflows/mysql-init.yml
- **🧾 고객 명함 생성 + 암호화 + 복호화 + 비교 자동화 (echo 완전 적용)**: 
- **Install Java, Maven, NetBackup CLI & Ledger Generation**: 
- **Delete Failed Workflow Runs**:     - cron: '0 3 * * *' Runs every day at 3 AM UTC
- **Install Java, Maven, NetBackup CLI & Ledger Generation with Customer List**: 
- **🤖 Auto-Approve & Merge Dependabot PRs**: 
- **🛠️ Dependabot Recovery & Sanity Check**:           [ ! -f Dockerfile ] && echo "Dummy Dockerfile" > Dockerfile
- **DevSkim**: This workflow uses actions that are not certified by GitHub.
- **🐳 Docker Finance Backup with GHCR + Kafka-style Logging**:           echo 'RUN mkdir -p /app && echo "금융 거래 로그 시뮬레이션" > /app/transactions.log' >> Dockerfile
- **📄 Provenance Index Generator**:             Build tag-specific index
- **Setup & Load Loans Ledger with Backup and Tags**:     - cron: '0 * * * *'  매 시간 정각마다 실행
- **Generate and Backup Corporate Banking Data with Secure ZIP and Conditional OCI Upload**:           echo "YAML configuration moved into separate file manually." > config/banking_schema.yaml
- **🔐 금융 거래 자동 백업**:     - cron: "*/5 * * * *"  5분 간격
- **📄 Provenance Index Generator**:             Append table row to tag-specific index markdown file
- **Hourly Docker Setup1**: 
- **Download Security Regulations**: .github/workflows/download-security-regulations.yml
- **🔐 암호화/복호화 + Codex 요금 추적**:           echo "💵 Codex 요금 추적 보고서" > $TAG_REPORT
- **🧾 Multi-Transaction Backup (Per-Type Containers)**: 
- **Build & Simulate Finance Transactions**: 
- **PostgreSQL DB 백업 및 S3 업로드**:   workflow_dispatch: GitHub UI에서 수동 실행 가능하도록 설정
- **🚀 Full Finance + Provenance + Pages Deployment**: 
- **Full Finance and Scorecard Setup**: 
- **🏦 Generate Customer Data + Provenance + Logs + Backup**: 
- **Install Java, Maven, NetBackup CLI & Ledger Generation**: 
- **Generate Repository Blog**: 
- **🧾 Update README with Portfolio and Workflows**:     - cron: '0 * * * *' 매 시간 정각 (UTC)
- **실패한 워크플로 자동 재시도 # 이 워크플로우의 이름입니다.**: name: 실패한 워크플로 자동 재시도 이 워크플로우의 이름입니다.
- **📃 Backup GitHub Workflows with Echo and Commit**:     - cron: '*/5 * * * *'  매 5분마다 실행
- **Install Java, Maven, NetBackup CLI & Ledger Generation with Customer List**: 
- **🔁 Auto Finance Backup (Manual + Cron)**:     - cron: "*/5 * * * *"  매 5분마다 실행
- **🏷️ Label and Comment Automation**:     - cron: '0 * * * *'  매시간 정각 실행 (UTC)
- **🔁 Auto Finance Backup (No Manual Trigger)**:     - cron: "*/5 * * * *"  ⏰ 매 5분마다 자동 실행
- **🦾 거래 자동화 - PDF 영수증 포함**: 
- **🌀 Resident Batch Log Backup**:                 sleep 300  5분 간격
- **♻️ Regenerate Workflow (Echo + Dependabot)**: 예: 워크플로우에서 최신 finance-backup.yml 자동 재생성
- **🧾 Multi-Transaction Backup (Per-Type Containers)**: 
- **🐬 Full MySQL Workflow with Auto Recovery, GPG, CSV, ZIP**: 
- **🐬 MySQL Setup & Migration**: 
- **MySQL Latest Version Upgrade**:         기존 MySQL 설치 제거 시도 (선택 사항, 클린 설치를 원할 경우)
- **OSV-Scanner**: 
- **♾️ Transfer Log Backup - Cron (60건 Infinite)**:   매 5분마다 자동 실행
- **Download Security Regulations**: .github/workflows/download-security-regulations.yml
- **🐍 Secure Python Package Build**:             echo "pip-audit report" > site/pip-audit-report.md
- **📦 Create GitHub Release**: 
- **Create GitHub Release**: .github/workflows/release1.yml
- **🧾 금융 거래 자동화 (PDF 영수증 포함)**: 
- **🛡️ OpenSSF Scorecard Analysis (Docker Only)**: 
- **🏗️ Full Loan Simulation & Document Generation**:             sed -i "1i📄 Loan Transaction Document\n\n**Loan ID:** $loan_id\n\n| Customer | Amount | Date |\n|---|---|---|" "$file"
- **🛡️ OPA 정책 자동화 및 Spring 연동**:       선택 사항: GitHub Pages 배포 또는 upload-artifact 수행 가능
- **Setup & Load Loans Ledger with Backup and Tags**: 
- **🐬 MySQL Backup with Dynamic Port & Persistent Containers**:           PORT=$((RANDOM%1000+3307))  3307~4306 사이 포트
- **💳 카드사별 거래 백업 + NetBackup + OCI 업로드**: 
- **🐳 Docker Build & Run with Echo**:           echo "Dockerized Ledger App" > app/README.md
- **CI with OpenAI API Usage Logging via Echo**: 
- **💸 Transfer Log Backup (Resident Batch)**:           샘플 계좌이체 로그 생성
- **♾️ Transfer Log Backup - Cron (60건 Infinite)**:   매 5분마다 자동 실행
- **♾️ Infinite Transfer Log Backup (Resident)**: 
- **Repo Analysis and README Update # 워크플로우의 이름**: name: Repo Analysis and README Update 워크플로우의 이름
- **Repo Analysis and README Update # 워크플로우의 이름 (기존 이름 유지)**: name: Repo Analysis and README Update 워크플로우의 이름 (기존 이름 유지)
- **Welcome to the Microsoft Generative AI**:     - cron: '0 * * * *'  매시간 정각 실행
- **Update README**: ← 이 부분을 추가해서 GITHUB_TOKEN에 쓰기 권한 부여
