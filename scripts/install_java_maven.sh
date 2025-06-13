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

# Install Java and Maven from apt
sudo apt-get update
sudo apt-get install -y wget tar openjdk-21-jdk maven

# Link installed software to /opt paths
JAVA_HOME=$(dirname $(dirname $(readlink -f $(which javac))))
MAVEN_HOME=$(dirname $(dirname $(readlink -f $(which mvn))))
sudo ln -sfn "$JAVA_HOME" "$JAVA_DIR"
sudo ln -sfn "$MAVEN_HOME" "$MAVEN_DIR"

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
