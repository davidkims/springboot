# Python Installation Guide

This guide explains how to install Python, run a simple script, and containerize the application.

## Install Python on Ubuntu
```bash
sudo apt update
sudo apt install -y python3 python3-venv python3-pip
```

Verify the installation:
```bash
python3 --version
```

## Run a Python script
Assuming you have a file named `hello.py`:
```bash
python3 hello.py
```

## Docker container
Create a `Dockerfile` with the following contents:
```dockerfile
FROM python:3.11-slim
COPY hello.py /app/hello.py
CMD ["python3", "/app/hello.py"]
```

Build the image and run it:
```bash
docker build -t python-hello .
docker run --rm python-hello
```
