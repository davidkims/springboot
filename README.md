## 🔧 GitHub Actions 워크플로우 요약

| 워크플로우 파일 | 워크플로우 이름 | 트리거 | 주요 작업 |
|----------------|----------------|--------|-----------|
| auto-backup.yml | 🔁 Auto Finance Backup (Manual + Cron) | schedule, workflow_dispatch | Finance MySQL backup |
| auto-transactions.yml | 🧱 Maven Build (echo 버전) | push, workflow_dispatch | Maven project build |
| bankbackup.yml | 🔄 Finance Smart Backup with PostgreSQL & Kafka | workflow_dispatch | PostgreSQL backup & Kafka log |
| billing.yml | 키 가가이드 - PDF 영수증 포함 | push, workflow_dispatch | Generate transactions & receipts |
| cash.yml | 🧾 결제 자동화 - PDF 영수증 포함 | push, workflow_dispatch | Ledger generation & artifact upload |
| customer-image-docker.yml | 🧾 고객 명함 생성 + 암호화 + 복호화 + 비교 자동화 (echo 완전 적용) | push, workflow_dispatch | Build customer card images with encryption |
| docker-backup-workflow.yml | 🐳 Docker Finance Backup with GHCR + Kafka-style Logging | schedule, workflow_dispatch | Docker backup image & push |
| docker-finance-build.yml | 🔐 금융 거래 자동 백업 | push, schedule, workflow_dispatch | MySQL container build & backup |
| finance-backup-multi.yml | 🧾 Multi-Transaction Backup (Per-Type Containers) | workflow_dispatch | Multi-container backups |
| finance-docker.yml | Build & Simulate Finance Transactions | push, workflow_dispatch | Build Docker image & simulate finance |
| finance-smart-backup.yml | 🔄 Finance Smart Backup without OTP | schedule, workflow_dispatch | Scheduled finance backup |
| label.yml | 🔁 Auto Finance Backup (No Manual Trigger) | schedule | Scheduled MySQL backup |
| ledger-generator.yml | 🦾 거래 자동화 - PDF 영수증 포함 | push, workflow_dispatch | Ledger and receipt generation |
| log-backup-container.yml | 🌀 Resident Batch Log Backup | workflow_dispatch | Resident container log backup |
| mysql-setup.yml | 🐬 MySQL Setup & Migration | workflow_dispatch | Setup MySQL and apply migrations |
| retrigger-and-db-init.yml | 🧾 금융 거래 자동화 (PDF 영수증 포함) | push, workflow_dispatch | Auto finance transactions with receipts |
| sql-backup-and-migrate.yml | 🐬 MySQL Backup with Dynamic Port & Persistent Containers | workflow_dispatch | Backup & migrate MySQL |
| swift-backup.yml | 💳 카드사별 거래 백업 + NetBackup + OCI 업로드 | push, workflow_dispatch | NetBackup and OCI upload |
| test.yml | 🐳 Docker Build & Run with Echo | push, workflow_dispatch | Docker build test |
| transfer-log-backup.yml | 💸 Transfer Log Backup (Resident Batch) | workflow_dispatch | Transfer log backup |
| transfer-log-backup1.yml | ♾️ Transfer Log Backup - Infinite Resident Container | workflow_dispatch | Continuous transfer log backup |
| transfer-log-infinite-backup.yml | ♾️ Infinite Transfer Log Backup (Resident) | workflow_dispatch | Infinite transfer log backup |

