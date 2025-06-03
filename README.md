## 🔧 GitHub Actions 워크플로우 요약

| 워크플로우 파일 | 워크플로우 이름 | 트리거 | 주요 작업 |
|----------------|----------------|--------|-----------|
| ci.yml         | CI Build       | push, pull_request | test, build |
| deploy.yml     | Prod Deploy    | push               | deploy      |
| blank.yml      | ⚠️ YAML 오류    | 파싱 실패          | N/A         |
