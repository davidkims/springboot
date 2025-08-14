FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    openjdk-17-jdk \
    python3 \
    python3-pip \
    mysql-client \
 && rm -rf /var/lib/apt/lists/*

CMD ["python3", "-c", "print('Defender Watchdog ready')"]
