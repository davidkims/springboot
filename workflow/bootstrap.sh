#!/bin/bash
set -e

USERNAME="worker"
PASSWORD="$(openssl rand -base64 12)"

useradd -m -s /bin/bash "$USERNAME"
echo "$USERNAME:$PASSWORD" | chpasswd
usermod -aG sudo "$USERNAME"

echo "초기 사용자/패스워드:"
echo "$USERNAME / $PASSWORD"

echo "0 0 * * * /usr/local/bin/rotate_accounts.py >> /var/log/rotate_accounts.log 2>&1" | crontab -

service cron start
tail -f /dev/null
