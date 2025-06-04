## 🔧 GitHub Actions 워크플로우 요약

| 워크플로우 파일 | 워크플로우 이름 | 트리거 | 주요 작업 |
|----------------|----------------|--------|-----------|
| auto-backup.yml | Auto Finance Backup | schedule, workflow_dispatch | MySQL backup |
| customer-image-docker.yml | 고객 명함 생성 컨테이너 | push, workflow_dispatch | Docker build & run |
| test.yml       | Docker Build Test | push, workflow_dispatch | build and run |
