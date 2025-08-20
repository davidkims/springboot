#!/usr/bin/env bash
set -euo pipefail

# This script demonstrates a full workflow that:
# 1. Builds a Docker image that echoes a bank statement file.
# 2. Installs Teradata CLI (placeholder if packages are unavailable).
# 3. Starts a MariaDB container and creates a financial statements table.
# 4. Runs a sample query against the table.
# 5. Installs a cron job to run the workflow every 10 minutes.

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

build_echo_image() {
  local image_name="bank-echo"
  local tmp_dir="${SCRIPT_DIR}/.echo"
  mkdir -p "$tmp_dir"
  cat >"${tmp_dir}/Dockerfile" <<'DOCKER'
FROM alpine:3.18
RUN apk add --no-cache bash
COPY generate_statement.sh /usr/local/bin/generate_statement.sh
RUN chmod +x /usr/local/bin/generate_statement.sh
CMD ["/usr/local/bin/generate_statement.sh"]
DOCKER

  cat >"${tmp_dir}/generate_statement.sh" <<'SCRIPT'
#!/usr/bin/env bash
set -euo pipefail
mkdir -p /data
printf "%s\n" "$(date -Iseconds) - Generated bank statement" > /data/statement.txt
SCRIPT
  chmod +x "${tmp_dir}/generate_statement.sh"
  docker build -t "$image_name" "$tmp_dir"
}

install_teradata_cli() {
  if ! command -v tdsql >/dev/null 2>&1; then
    echo "Installing Teradata CLI (placeholder)..."
    sudo apt-get update || true
    sudo apt-get install -y cliv2 || echo "Teradata CLI package not found; skipping"
  fi
}

start_mariadb() {
  if ! docker ps --format '{{.Names}}' | grep -q '^bank-db$'; then
    docker run -d --name bank-db -e MYSQL_ROOT_PASSWORD=secret mariadb:10.11
    sleep 20
  fi
  docker exec bank-db mysql -uroot -psecret <<'SQL'
CREATE DATABASE IF NOT EXISTS finance;
USE finance;
CREATE TABLE IF NOT EXISTS statements (
  id INT AUTO_INCREMENT PRIMARY KEY,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  note VARCHAR(255)
);
INSERT INTO statements(note) VALUES ('initial');
SQL
}

query_financials() {
  docker exec bank-db mysql -uroot -psecret -e "USE finance; SELECT * FROM statements;"
}

setup_cron() {
  local cron_file="/etc/cron.d/financial_workflow"
  local script_path="$(realpath "$0")"
  local cron_entry="*/10 * * * * root $script_path run"
  echo "$cron_entry" | sudo tee "$cron_file" >/dev/null
  sudo chmod 644 "$cron_file"
  sudo systemctl reload cron || sudo service cron reload
  echo "Cron job installed to run every 10 minutes."
}

run() {
  build_echo_image
  install_teradata_cli
  start_mariadb
  query_financials
}

case "${1:-}" in
  run)
    run
    ;;
  install-cron)
    setup_cron
    ;;
  *)
    echo "Usage: $0 {run|install-cron}"
    exit 1
    ;;
esac
