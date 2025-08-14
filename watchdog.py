import os
import mysql.connector


def main():
    host = os.getenv('MYSQL_HOST', '127.0.0.1')
    user = os.getenv('MYSQL_USER', 'defender')
    password = os.getenv('MYSQL_PASSWORD', 'defenderpass')
    database = os.getenv('MYSQL_DATABASE', 'defenderdb')
    port = int(os.getenv('MYSQL_PORT', '3306'))
    try:
        conn = mysql.connector.connect(host=host, user=user, password=password, database=database, port=port)
        conn.close()
        print('Watchdog: MySQL connection successful')
    except Exception as e:
        print(f'Watchdog: database connection failed: {e}')


if __name__ == '__main__':
    main()
