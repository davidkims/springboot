#!/usr/bin/env bash
set -euo pipefail

# Default configuration
: "${MYSQL_ROOT_PASSWORD:=rootpass123}"
: "${MYSQL_DB:=example_db}"
: "${MYSQL_USER:=example_user}"
: "${MYSQL_PASS:=example_pass}"
: "${MIGRATION_FILE:=migrations/init.sql}"

install_mysql() {
  if ! command -v mysql >/dev/null 2>&1; then
    sudo apt-get update
    sudo DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server
  fi
}

secure_mysql() {
  sudo systemctl stop mysql
  sudo mysqld_safe --skip-networking --skip-grant-tables &
  sleep 10
  echo "FLUSH PRIVILEGES; ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '${MYSQL_ROOT_PASSWORD}'; FLUSH PRIVILEGES;" | sudo mysql -u root
  sudo killall mysqld
  sleep 5
  sudo systemctl start mysql
}

create_db_and_user() {
  mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DB};"
  mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'localhost' IDENTIFIED BY '${MYSQL_PASS}';"
  mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "GRANT ALL PRIVILEGES ON ${MYSQL_DB}.* TO '${MYSQL_USER}'@'localhost';"
  mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "FLUSH PRIVILEGES;"
}

run_migration() {
  if [ -f "${MIGRATION_FILE}" ]; then
    mysql -u "${MYSQL_USER}" -p"${MYSQL_PASS}" "${MYSQL_DB}" < "${MIGRATION_FILE}"
  else
    echo "Migration file ${MIGRATION_FILE} not found" >&2
    exit 1
  fi
}

show_count() {
  mysql -u "${MYSQL_USER}" -p"${MYSQL_PASS}" -N -e "USE ${MYSQL_DB}; SELECT COUNT(*) FROM sample_table;"
}

main() {
  install_mysql
  secure_mysql
  create_db_and_user
  run_migration
  echo "Row count in sample_table:"
  show_count
}

main "$@"
