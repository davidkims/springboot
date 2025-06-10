#!/usr/bin/env bash
set -euo pipefail

# Number of transactions to generate (default 1000)
: "${NUM_TRANSACTIONS:=1000}"
: "${MYSQL_USER:=finance_user}"
: "${MYSQL_PASS:=finance_pass}"
: "${MYSQL_DB:=finance_db}"

cat <<SQL | mysql -u "$MYSQL_USER" -p"$MYSQL_PASS" "$MYSQL_DB"
CREATE TABLE IF NOT EXISTS shinhan_transactions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100),
    account_number VARCHAR(20),
    amount DECIMAL(12,2),
    currency VARCHAR(10),
    transaction_date DATETIME DEFAULT CURRENT_TIMESTAMP
);
SQL

echo "Inserting $NUM_TRANSACTIONS transactions into $MYSQL_DB.shinhan_transactions"
for i in $(seq 1 "$NUM_TRANSACTIONS"); do
  NAME="Customer_$i"
  ACC_NUM=$(printf '110-%06d-%06d' $((RANDOM%1000000)) $((RANDOM%1000000)))
  AMOUNT=$(( RANDOM % 1000000 + 100 ))
  CURRENCY="KRW"
  cat <<SQL | mysql -u "$MYSQL_USER" -p"$MYSQL_PASS" "$MYSQL_DB"
INSERT INTO shinhan_transactions (customer_name, account_number, amount, currency)
VALUES ('$NAME', '$ACC_NUM', $AMOUNT, '$CURRENCY');
SQL
  # small delay to avoid overwhelming MySQL
  sleep 0.01
done

echo "Done." 
