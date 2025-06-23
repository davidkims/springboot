# Docker Installation Guide

This guide covers installing Docker on Ubuntu, building a simple image, and running a container.

## Install Docker
```bash
sudo apt update
sudo apt install -y docker.io
sudo systemctl enable --now docker
```

Verify installation:
```bash
docker --version
```

## Build a sample image
Create a `Dockerfile`:
```dockerfile
FROM alpine:3.19
CMD ["echo", "Docker is running"]
```

Build the image and start a container:
```bash
docker build -t sample-image .
docker run --rm sample-image
```
