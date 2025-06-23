# Go Installation Guide

This guide explains how to install Go, run a simple program, and containerize it.

## Install Go on Ubuntu
```bash
sudo apt update
sudo apt install -y golang-go
```

Check the version:
```bash
go version
```

## Run a Go program
With a file named `hello.go`:
```bash
go run hello.go
```

## Docker container
Create a `Dockerfile`:
```dockerfile
FROM golang:1.20
WORKDIR /app
COPY hello.go .
RUN go build -o hello .
CMD ["/app/hello"]
```

Build and run the image:
```bash
docker build -t go-hello .
docker run --rm go-hello
```
