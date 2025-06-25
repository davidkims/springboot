# MySQL Setup and Migration Guide

This guide explains how to install MySQL, run a simple migration, and check the number of rows inserted.

## Install MySQL on Ubuntu
```bash
sudo apt update
sudo DEBIAN_FRONTEND=noninteractive apt install -y mysql-server
```

## Run the migration script
Inside the repository root:
```bash
./scripts/mysql_install_and_migrate.sh
```
This script installs MySQL if needed, creates a database and user, runs `migrations/init.sql`, and prints the row count from `sample_table`.
