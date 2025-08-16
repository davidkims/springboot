#!/usr/bin/env python3
"""
Bulk workflow script for disk creation, table creation, and query generation.
Runs refresh every 5 minutes.
"""

import sqlite3
import time
from pathlib import Path

# Paths for generated resources
BASE_DIR = Path(__file__).resolve().parent
GENERATED_DIR = BASE_DIR / "generated"
DISK_DIR = GENERATED_DIR / "disks"
DB_PATH = GENERATED_DIR / "bulk.db"


def create_disks(count: int, size_kb: int = 1) -> None:
    """Create ``count`` fake disk image files of ``size_kb`` kilobytes."""
    DISK_DIR.mkdir(parents=True, exist_ok=True)
    for i in range(count):
        disk_path = DISK_DIR / f"disk_{i}.img"
        # Create a small file to simulate a disk image.
        with open(disk_path, "wb") as f:
            f.write(b"\0" * 1024 * size_kb)
        print(f"[disk] 생성 완료: {disk_path}")


def create_tables(conn: sqlite3.Connection, count: int) -> None:
    """Create ``count`` tables in the SQLite database."""
    for i in range(count):
        conn.execute(
            f"CREATE TABLE IF NOT EXISTS table_{i} (id INTEGER PRIMARY KEY, value TEXT)"
        )
    conn.commit()
    print(f"[table] {count}개 테이블 생성")


def generate_queries(count: int) -> list[str]:
    """Generate ``count`` simple SELECT queries."""
    queries = [f"SELECT * FROM table_{i} WHERE id = 1" for i in range(count)]
    print(f"[query] {count}개 쿼리 생성")
    return queries


def refresh_every_five_minutes() -> None:
    """Run the workflow repeatedly every five minutes."""
    while True:
        with sqlite3.connect(DB_PATH) as conn:
            create_disks(10)
            create_tables(conn, 10)
            generate_queries(10)
        print("[refresh] 작업 완료, 5분 후 재실행")
        time.sleep(300)


if __name__ == "__main__":
    refresh_every_five_minutes()
