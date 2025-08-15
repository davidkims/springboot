#!/usr/bin/env python3
import secrets
import base64
import subprocess

USERNAME = "worker"

def rotate_password():
    new_pwd = base64.b64encode(secrets.token_bytes(12)).decode()
    subprocess.run(["chpasswd"], input=f"{USERNAME}:{new_pwd}".encode(), check=True)
    print(f"[rotate_accounts] {USERNAME} 새 비밀번호: {new_pwd}")

if __name__ == "__main__":
    rotate_password()
