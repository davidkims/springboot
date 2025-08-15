FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    python3 python3-pip cron sudo openssl

COPY bootstrap.sh /usr/local/bin/bootstrap.sh
COPY rotate_accounts.py /usr/local/bin/rotate_accounts.py

RUN chmod +x /usr/local/bin/bootstrap.sh \
    && chmod +x /usr/local/bin/rotate_accounts.py

ENTRYPOINT ["/usr/local/bin/bootstrap.sh"]
