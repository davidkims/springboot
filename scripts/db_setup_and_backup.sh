#!/usr/bin/env bash
set -euxo pipefail

# ─── 환경 변수 (필요 시 오버라이드 가능) ───────────────────────────────────────
: "${MYSQL_ROOT_PASSWORD:=rootpass123}"
: "${MYSQL_DB:=finance_db}"
: "${MYSQL_USER:=finance_user}"
: "${MYSQL_PASS:=finance_pass}"

: "${PG_DB:=finance_pg_db}"
: "${PG_USER:=finance_pg_user}"
: "${PG_PASS:=pg_pass}"

: "${BACKUP_DIR:=/opt/db_backups}"
: "${DISK_SLOT:=${BACKUP_DIR}/.disk_slot}"

# ─── 디스크 슬롯 및 백업 디렉토리 준비 ────────────────────────────────────────
sudo mkdir -p "${BACKUP_DIR}"
sudo fallocate -l 5G "${DISK_SLOT}" || \
  sudo dd if=/dev/zero of="${DISK_SLOT}" bs=1M count=5120
sudo chmod -R 777 "${BACKUP_DIR}"

# ─── MySQL & PostgreSQL 설치 ─────────────────────────────────────────────────
sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server postgresql

# ─── MySQL root 비밀번호 설정 ────────────────────────────────────────────────
sudo systemctl stop mysql
sudo mysqld_safe --skip-networking --skip-grant-tables &
sleep 10
echo "
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost'
  IDENTIFIED WITH mysql_native_password
  BY '${MYSQL_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
" | sudo mysql -u root
sudo killall mysqld
sleep 5
sudo systemctl start mysql
sudo systemctl enable mysql

# ─── MySQL DB & 유저 생성 ───────────────────────────────────────────────────
mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e \
  "CREATE DATABASE IF NOT EXISTS ${MYSQL_DB};"
mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e \
  "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'localhost' IDENTIFIED BY '${MYSQL_PASS}';"
mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e \
  "GRANT ALL PRIVILEGES ON ${MYSQL_DB}.* TO '${MYSQL_USER}'@'localhost';"
mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "FLUSH PRIVILEGES;"

# ─── PostgreSQL 설정 및 DB 생성 ──────────────────────────────────────────────
sudo systemctl start postgresql
sudo systemctl enable postgresql

# 사용자 생성
sudo -u postgres psql -tc \
  "SELECT 1 FROM pg_roles WHERE rolname='${PG_USER}'" | grep -q 1 || \
  sudo -u postgres psql -c \
    "CREATE USER ${PG_USER} WITH PASSWORD '${PG_PASS}';"

# 데이터베이스 생성
sudo -u postgres psql -lqt | cut -d \| -f 1 | grep -w "${PG_DB}" | grep -q "^${PG_DB}" || \
  sudo -u postgres createdb -O "${PG_USER}" "${PG_DB}"

# ─── 백업 디렉토리 생성 & 덤프 ────────────────────────────────────────────────
mkdir -p "${BACKUP_DIR}/mysql" "${BACKUP_DIR}/postgres"

mysqldump -u "${MYSQL_USER}" -p"${MYSQL_PASS}" \
  "${MYSQL_DB}" > "${BACKUP_DIR}/mysql/${MYSQL_DB}.sql"

sudo -u postgres pg_dump "${PG_DB}" > \
  "${BACKUP_DIR}/postgres/${PG_DB}.sql"

echo "Backups stored in ${BACKUP_DIR}"
