#!/usr/bin/env bash
set -euo pipefail

# Directories
MAVEN_DIR="/opt/maven"
SPRING_DIR="/opt/springboot"
BACKUP_ROOT="/opt/backups"
DATE_TAG="$(date +%Y%m%d%H%M%S)"

# Create directories
sudo mkdir -p "$MAVEN_DIR" "$SPRING_DIR" "$BACKUP_ROOT"

# Backup existing installations
for dir in "$MAVEN_DIR" "$SPRING_DIR"; do
  if [ -d "$dir" ] && [ "$(ls -A "$dir")" ]; then
    backup="$BACKUP_ROOT/$(basename "$dir")-$DATE_TAG.tar.gz"
    sudo tar -czf "$backup" -C "$dir" .
    echo "Backed up $dir to $backup"
  fi
  sudo rm -rf "$dir"/*
done

# Install latest Maven
MAVEN_VERSION=$(curl -s https://api.github.com/repos/apache/maven/releases/latest | grep tag_name | cut -d '"' -f4)
MAVEN_URL="https://downloads.apache.org/maven/maven-3/${MAVEN_VERSION#v}/binaries/apache-maven-${MAVEN_VERSION#v}-bin.tar.gz"
wget -O /tmp/maven.tar.gz "$MAVEN_URL"
sudo tar -xzf /tmp/maven.tar.gz -C "$MAVEN_DIR" --strip-components=1

# Install latest Spring Boot CLI
SPRING_VERSION=$(curl -s https://api.github.com/repos/spring-projects/spring-boot/releases/latest | grep tag_name | cut -d '"' -f4)
SPRING_URL="https://repo.spring.io/release/org/springframework/boot/spring-boot-cli/${SPRING_VERSION}/spring-boot-cli-${SPRING_VERSION}-bin.tar.gz"
wget -O /tmp/springboot.tar.gz "$SPRING_URL"
sudo tar -xzf /tmp/springboot.tar.gz -C "$SPRING_DIR" --strip-components=1

# Install or upgrade Apache HTTP Server
sudo apt-get update
sudo apt-get install -y apache2
sudo systemctl enable --now apache2

echo "Maven, Spring Boot, and Apache installation complete."
