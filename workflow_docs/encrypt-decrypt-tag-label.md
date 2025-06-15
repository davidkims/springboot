# 🔐 암호화/복호화 + Codex 요금 추적

Source: `.github/workflows/encrypt-decrypt-tag-label.yml`

**Triggers**: workflow_dispatch, push

## Steps
- 📁 저장소 체크아웃
- 🔑 Generate OpenAI token
- Skip when token missing
- 🔐 암호화 / 복호화 태그 파일 생성
- 💰 Codex 요금 API 호출 및 보고서 생성
- 🧾 태그 및 보고서 아카이브
