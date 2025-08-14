FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    openjdk-17-jdk \
    python3 python3-pip \
    mysql-client \
    sudo curl wget git && \
    rm -rf /var/lib/apt/lists/*

RUN useradd -m defender && echo "defender ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER defender
WORKDIR /home/defender

COPY requirements.txt ./
RUN pip3 install --no-cache-dir -r requirements.txt

COPY . /home/defender/app
WORKDIR /home/defender/app

CMD ["python3", "watchdog.py"]
