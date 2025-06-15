FROM ubuntu:22.04

RUN apt-get update && \
    apt-get install -y curl

COPY start.sh /app/start.sh

CMD ["bash", "/app/start.sh"]
