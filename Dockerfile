FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    openjdk-17-jdk \
    python3 \
    python3-pip \
    mysql-client \
    tzdata \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /opt/defender
COPY requirements.txt ./
RUN pip3 install --no-cache-dir -r requirements.txt
COPY watchdog.py ./

CMD ["python3", "watchdog.py"]
