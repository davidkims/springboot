# Disk & Cache Optimizer with Git Tagging

Source: `.github/workflows/disk-optimizer.yml`

**Triggers**: workflow_dispatch

## Steps
- 리포지토리 체크아웃
- 초기 디스크 사용량 보고
- 불필요한 Docker 리소스 정리
- 캐시 디렉토리 생성 확인
- 종속성 캐시 복원
- package.json 존재 여부 확인 (Node.js 프로젝트용)
- Node.js 종속성 설치
- Node.js 종속성 캐시 저장
- 사용자 정의 디스크 최적화 스크립트 실행
- Git 태그 생성 및 푸시
