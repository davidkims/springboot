# CI with OpenAI API Usage Logging via Echo

Source: `.github/workflows/tokencheck.yml`

**Triggers**: push, pull_request, workflow_dispatch

## Steps
- 🔑 Generate OpenAI token
- Skip job when token missing
- Set up Python
- Install OpenAI SDK (v1.x 이상)
- Write OpenAI Usage Script (echo)
- Run OpenAI API Usage Script
- ✅ Final Log
