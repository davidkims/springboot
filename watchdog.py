#!/usr/bin/env python3
import os
import time
import subprocess
import mysql.connector
from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler


class ServiceHandler(FileSystemEventHandler):
    """Restart services when service files change."""

    def on_modified(self, event):
        if event.src_path.endswith('.service'):
            subprocess.run(
                ["echo", f"systemctl restart {os.path.basename(event.src_path)}"],
                check=False,
            )


def monitor_logs(path):
    """Watch a log file and emit alerts on errors."""
    if os.path.exists(path):
        with open(path, 'r') as f:
            f.seek(0, os.SEEK_END)
            while True:
                line = f.readline()
                if not line:
                    time.sleep(1)
                    continue
                if 'ERROR' in line:
                    subprocess.run(["echo", f"[ALERT] {line.strip()}"] , check=False)
    else:
        subprocess.run(["echo", f"Log file not found: {path}"], check=False)


def check_db():
    """Verify MySQL connectivity."""
    host = os.getenv('MYSQL_HOST', '127.0.0.1')
    user = os.getenv('MYSQL_USER', 'defender')
    password = os.getenv('MYSQL_PASSWORD', 'defenderpass')
    database = os.getenv('MYSQL_DATABASE', 'defenderdb')
    port = int(os.getenv('MYSQL_PORT', '3306'))
    try:
        mysql.connector.connect(
            host=host, user=user, password=password, database=database, port=port
        ).close()
        subprocess.run(["echo", "Watchdog: MySQL connection successful"], check=False)
    except Exception as e:
        subprocess.run(["echo", f"Watchdog: database connection failed: {e}"] , check=False)


if __name__ == '__main__':
    observer = Observer()
    service_dir = '/home/defender/app/services'
    os.makedirs(service_dir, exist_ok=True)
    observer.schedule(ServiceHandler(), path=service_dir, recursive=True)
    observer.start()
    try:
        check_db()
        monitor_logs('/home/defender/app/logs/app.log')
    finally:
        observer.stop()
        observer.join()
