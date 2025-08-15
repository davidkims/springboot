#!/usr/bin/env bash
set -euo pipefail

# Workflow script to install or upgrade MySQL and MariaDB,
# create random database users with generated passwords,
# grant privileges, and create batches of directories and files.

: "${MYSQL_DB:=sample_mysql_db}"
: "${MARIADB_DB:=sample_mariadb_db}"

# Directories and files to create
DIRS=("/opt/db/backups" "/opt/db/data" "/opt/db/logs")
FILES=("/opt/db/backups/README" "/opt/db/data/.keep")

random_password() {
  openssl rand -base64 16
}

install_mysql() {
  sudo apt-get update
  sudo DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server
  sudo DEBIAN_FRONTEND=noninteractive apt-get install -y --only-upgrade mysql-server
}

create_mysql_user() {
  local user="mysql_$(openssl rand -hex 4)"
  local pass
  pass=$(random_password)
  mysql -u root -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DB};"
  mysql -u root -e "CREATE USER IF NOT EXISTS '${user}'@'localhost' IDENTIFIED BY '${pass}';"
  mysql -u root -e "GRANT ALL PRIVILEGES ON ${MYSQL_DB}.* TO '${user}'@'localhost'; FLUSH PRIVILEGES;"
  echo "MySQL user: ${user}"
  echo "MySQL password: ${pass}"
}

install_mariadb() {
  sudo apt-get update
  sudo DEBIAN_FRONTEND=noninteractive apt-get install -y mariadb-server
  sudo DEBIAN_FRONTEND=noninteractive apt-get install -y --only-upgrade mariadb-server
}

create_mariadb_user() {
  local user="maria_$(openssl rand -hex 4)"
  local pass
  pass=$(random_password)
  sudo mysql -u root -e "CREATE DATABASE IF NOT EXISTS ${MARIADB_DB};"
  sudo mysql -u root -e "CREATE USER IF NOT EXISTS '${user}'@'localhost' IDENTIFIED BY '${pass}';"
  sudo mysql -u root -e "GRANT ALL PRIVILEGES ON ${MARIADB_DB}.* TO '${user}'@'localhost'; FLUSH PRIVILEGES;"
  echo "MariaDB user: ${user}"
  echo "MariaDB password: ${pass}"
}

create_dirs_and_files() {
  for dir in "${DIRS[@]}"; do
    sudo mkdir -p "$dir"
  done
  for file in "${FILES[@]}"; do
    sudo mkdir -p "$(dirname "$file")"
    sudo touch "$file"
  done
}

main() {
  install_mysql
  create_mysql_user
  install_mariadb
  create_mariadb_user
  create_dirs_and_files
}

main "$@"
