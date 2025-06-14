# 🐬 MySQL Backup with Dynamic Port & Persistent Containers

Source: `.github/workflows/sql-backup-and-migrate.yml`

**Triggers**: workflow_dispatch

## Steps
- 📦 Checkout Repository
- 🕒 Generate Timestamp and Dynamic Port
- 🐳 Launch MySQL Backup Container
- 🔐 Generate Secure MySQL Login File (.my.cnf)
- 📁 Create Backup Directory
- 💾 Run mysqldump Backup
- 🔍 Print Container Info
