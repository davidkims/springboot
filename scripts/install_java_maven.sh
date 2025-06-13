#!/usr/bin/env bash
set -euo pipefail

# Directories
JAVA_DIR="/opt/java"
MAVEN_DIR="/opt/maven"
SPRING_DIR="/opt/springboot"
BACKUP_ROOT="/opt/backups"
DATE_TAG="$(date +%Y%m%d%H%M%S)"

# Create directories
sudo mkdir -p "$JAVA_DIR" "$MAVEN_DIR" "$SPRING_DIR" "$BACKUP_ROOT"

# Backup existing installations
for dir in "$JAVA_DIR" "$MAVEN_DIR" "$SPRING_DIR"; do
  if [ -d "$dir" ] && [ "$(ls -A "$dir")" ]; then
    backup="$BACKUP_ROOT/$(basename "$dir")-$DATE_TAG.tar.gz"
    sudo tar -czf "$backup" -C "$dir" .
    echo "Backed up $dir to $backup"
  fi
  sudo rm -rf "$dir"/*
done

# Install latest Java (Temurin)
sudo apt-get update
sudo apt-get install -y wget tar
JDK_URL="https://api.adoptium.net/v3/binary/latest/temurin?package=jdk&architecture=x64&heap_size=normal&image_type=jdk&os=linux&arch=x64"
wget -O /tmp/jdk.tar.gz "$JDK_URL"
sudo tar -xzf /tmp/jdk.tar.gz -C "$JAVA_DIR" --strip-components=1

# Install latest Maven
MAVEN_VERSION=$(curl -s https://api.github.com/repos/apache/maven/releases/latest | grep tag_name | cut -d '"' -f4)
MAVEN_URL="https://downloads.apache.org/maven/maven-3/${MAVEN_VERSION#v}/binaries/apache-maven-${MAVEN_VERSION#v}-bin.tar.gz"
wget -O /tmp/maven.tar.gz "$MAVEN_URL"
sudo tar -xzf /tmp/maven.tar.gz -C "$MAVEN_DIR" --strip-components=1

# Set permissions
sudo chmod -R 755 "$JAVA_DIR" "$MAVEN_DIR" "$SPRING_DIR"

# If springboot project exists, build and backup jar
if [ -f "$SPRING_DIR/pom.xml" ]; then
  "$MAVEN_DIR/bin/mvn" -f "$SPRING_DIR/pom.xml" clean package
  jar_file=$(find "$SPRING_DIR/target" -name '*.jar' | head -n 1)
  if [ -f "$jar_file" ]; then
    sudo cp "$jar_file" "$BACKUP_ROOT/springboot-$DATE_TAG.jar"
    echo "Spring Boot jar backed up to $BACKUP_ROOT/springboot-$DATE_TAG.jar"
  fi
fi

echo "Java and Maven installation complete."
