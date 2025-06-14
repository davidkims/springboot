#!/usr/bin/env python3
import os
import sqlite3
import argparse
import random
from datetime import datetime

DB_DIR = os.environ.get('DB_DIR', 'db_storage')
CUSTOMER_DB = os.path.join(DB_DIR, 'customer.db')
CREDIT_DB = os.path.join(DB_DIR, 'credit.db')


def create_dbs():
    os.makedirs(DB_DIR, exist_ok=True)
    with sqlite3.connect(CUSTOMER_DB) as conn:
        conn.execute(
            """CREATE TABLE IF NOT EXISTS transactions (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            customer_name TEXT,
            amount REAL,
            timestamp TEXT
        )"""
        )
    with sqlite3.connect(CREDIT_DB) as conn:
        conn.execute(
            """CREATE TABLE IF NOT EXISTS credit_customers (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            customer_name TEXT,
            credit_limit REAL
        )"""
        )
        conn.execute(
            """CREATE TABLE IF NOT EXISTS credit_transactions (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            customer_id INTEGER,
            amount REAL,
            timestamp TEXT,
            FOREIGN KEY(customer_id) REFERENCES credit_customers(id)
        )"""
        )
    print(f"Databases created in {DB_DIR}")


def generate_data(num):
    with sqlite3.connect(CUSTOMER_DB) as conn:
        for i in range(num):
            conn.execute(
                'INSERT INTO transactions (customer_name, amount, timestamp) VALUES (?, ?, ?)',
                (f"Customer_{i}", random.uniform(10, 1000), datetime.utcnow().isoformat()),
            )
        conn.commit()
    with sqlite3.connect(CREDIT_DB) as conn:
        for i in range(num):
            conn.execute(
                'INSERT INTO credit_customers (customer_name, credit_limit) VALUES (?, ?)',
                (f"CreditCustomer_{i}", random.uniform(1000, 5000)),
            )
            customer_id = conn.execute('SELECT last_insert_rowid()').fetchone()[0]
            conn.execute(
                'INSERT INTO credit_transactions (customer_id, amount, timestamp) VALUES (?, ?, ?)',
                (customer_id, random.uniform(100, 500), datetime.utcnow().isoformat()),
            )
        conn.commit()
    print(f"Inserted {num} records into each database")


def drop_dbs():
    removed = False
    for path in (CUSTOMER_DB, CREDIT_DB):
        if os.path.exists(path):
            os.remove(path)
            removed = True
    if removed:
        print("Databases removed")
    else:
        print("No database files found")


def main():
    parser = argparse.ArgumentParser(description='Finance database automation')
    sub = parser.add_subparsers(dest='command', required=True)

    sub.add_parser('create', help='Create database files and schema')
    gen = sub.add_parser('generate', help='Insert demo data')
    gen.add_argument('--num', type=int, default=1000, help='Number of records to insert')
    sub.add_parser('drop', help='Remove database files')

    args = parser.parse_args()

    if args.command == 'create':
        create_dbs()
    elif args.command == 'generate':
        generate_data(args.num)
    elif args.command == 'drop':
        drop_dbs()


if __name__ == '__main__':
    main()
