# MySQL Latest Version Upgrade

Source: `.github/workflows/mysql-upgrade.yml`

**Triggers**: workflow_dispatch

## Steps
- Checkout repository
- Set up MySQL APT repository
- Stop MySQL service (if running) and clean up
- Install/Upgrade MySQL Server to latest version
- Set MySQL data directory permissions (ensure correct ownership)
- Start MySQL service
- Run mysql_upgrade and restart service
- Verify MySQL version and check logs for errors
