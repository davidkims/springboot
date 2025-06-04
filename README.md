## 🔧 GitHub Actions 워크플로우 요약

아래 표에는 각 워크플로우의 설명과 실행 페이지 링크가 포함되어 있습니다.

| 워크플로우 파일 | 워크플로우 이름 | 트리거 | 주요 작업 | 실행 링크 |
|----------------|----------------|--------|-----------|-----------|
| auto-backup.yml | 🔁 Auto Finance Backup (Manual + Cron) | schedule, workflow_dispatch | Finance MySQL backup | [실행](https://github.com/davidkims/springboot/actions/workflows/auto-backup.yml) |
| auto-transactions.yml | 🧱 Maven Build (echo 버전) | push, workflow_dispatch | Maven project build | [실행](https://github.com/davidkims/springboot/actions/workflows/auto-transactions.yml) |
| bankbackup.yml | 🔄 Finance Smart Backup with PostgreSQL & Kafka | workflow_dispatch | PostgreSQL backup & Kafka log | [실행](https://github.com/davidkims/springboot/actions/workflows/bankbackup.yml) |
| billing.yml | 키 가가이드 - PDF 영수증 포함 | push, workflow_dispatch | Generate transactions & receipts | [실행](https://github.com/davidkims/springboot/actions/workflows/billing.yml) |
| cash.yml | 🧾 결제 자동화 - PDF 영수증 포함 | push, workflow_dispatch | Ledger generation & artifact upload | [실행](https://github.com/davidkims/springboot/actions/workflows/cash.yml) |
| customer-image-docker.yml | 🧾 고객 명함 생성 + 암호화 + 복호화 + 비교 자동화 (echo 완전 적용) | push, workflow_dispatch | Build customer card images with encryption | [실행](https://github.com/davidkims/springboot/actions/workflows/customer-image-docker.yml) |
| docker-backup-workflow.yml | 🐳 Docker Finance Backup with GHCR + Kafka-style Logging | schedule, workflow_dispatch | Docker backup image & push | [실행](https://github.com/davidkims/springboot/actions/workflows/docker-backup-workflow.yml) |
| docker-finance-build.yml | 🔐 금융 거래 자동 백업 | push, schedule, workflow_dispatch | MySQL container build & backup | [실행](https://github.com/davidkims/springboot/actions/workflows/docker-finance-build.yml) |
| finance-backup-multi.yml | 🧾 Multi-Transaction Backup (Per-Type Containers) | workflow_dispatch | Multi-container backups | [실행](https://github.com/davidkims/springboot/actions/workflows/finance-backup-multi.yml) |
| finance-docker.yml | Build & Simulate Finance Transactions | push, workflow_dispatch | Build Docker image & simulate finance | [실행](https://github.com/davidkims/springboot/actions/workflows/finance-docker.yml) |
| finance-smart-backup.yml | 🔄 Finance Smart Backup without OTP | schedule, workflow_dispatch | Scheduled finance backup | [실행](https://github.com/davidkims/springboot/actions/workflows/finance-smart-backup.yml) |
| label.yml | 🔁 Auto Finance Backup (No Manual Trigger) | schedule | Scheduled MySQL backup | [실행](https://github.com/davidkims/springboot/actions/workflows/label.yml) |
| ledger-generator.yml | 🦾 거래 자동화 - PDF 영수증 포함 | push, workflow_dispatch | Ledger and receipt generation | [실행](https://github.com/davidkims/springboot/actions/workflows/ledger-generator.yml) |
| log-backup-container.yml | 🌀 Resident Batch Log Backup | workflow_dispatch | Resident container log backup | [실행](https://github.com/davidkims/springboot/actions/workflows/log-backup-container.yml) |
| mysql-setup.yml | 🐬 MySQL Setup & Migration | workflow_dispatch | Setup MySQL and apply migrations | [실행](https://github.com/davidkims/springboot/actions/workflows/mysql-setup.yml) |
| retrigger-and-db-init.yml | 🧾 금융 거래 자동화 (PDF 영수증 포함) | push, workflow_dispatch | Auto finance transactions with receipts | [실행](https://github.com/davidkims/springboot/actions/workflows/retrigger-and-db-init.yml) |
| sql-backup-and-migrate.yml | 🐬 MySQL Backup with Dynamic Port & Persistent Containers | workflow_dispatch | Backup & migrate MySQL | [실행](https://github.com/davidkims/springboot/actions/workflows/sql-backup-and-migrate.yml) |
| swift-backup.yml | 💳 카드사별 거래 백업 + NetBackup + OCI 업로드 | push, workflow_dispatch | NetBackup and OCI upload | [실행](https://github.com/davidkims/springboot/actions/workflows/swift-backup.yml) |
| test.yml | 🐳 Docker Build & Run with Echo | push, workflow_dispatch | Docker build test | [실행](https://github.com/davidkims/springboot/actions/workflows/test.yml) |
| transfer-log-backup.yml | 💸 Transfer Log Backup (Resident Batch) | workflow_dispatch | Transfer log backup | [실행](https://github.com/davidkims/springboot/actions/workflows/transfer-log-backup.yml) |
| transfer-log-backup1.yml | ♾️ Transfer Log Backup - Infinite Resident Container | workflow_dispatch | Continuous transfer log backup | [실행](https://github.com/davidkims/springboot/actions/workflows/transfer-log-backup1.yml) |
| transfer-log-infinite-backup.yml | ♾️ Infinite Transfer Log Backup (Resident) | workflow_dispatch | Infinite transfer log backup | [실행](https://github.com/davidkims/springboot/actions/workflows/transfer-log-infinite-backup.yml) |

