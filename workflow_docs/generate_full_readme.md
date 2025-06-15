# Update README.md Every Hour

Source: `.github/workflows/generate_full_readme.yml`

**Triggers**: schedule, workflow_dispatch

## Steps
- >> 스텝 시작: 리포지토리 체크아웃
- 리포지토리 체크아웃
- << 스텝 완료: 리포지토리 체크아웃
- >> 스텝 시작: README.md 업데이트 스크립트 실행
- README.md 업데이트 스크립트 실행
- << 스텝 완료: README.md 업데이트 스크립트 실행
- >> 스텝 시작: 변경사항 감지 및 커밋/푸시
- 변경사항 감지 및 커밋/푸시
- << 스텝 완료: 변경사항 감지 및 커밋/푸시
- >> 워크플로우 실행 종료
