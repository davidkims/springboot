# Codespace Security Configuration Check

Source: `.github/workflows/codespace-security1-check.yml`

**Triggers**: pull_request

## Steps
- Checkout repository code
- Check devcontainer.json for insecure port forwarding
- Check Dockerfile for approved base image
- Notify security team if checks fail
