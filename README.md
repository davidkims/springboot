# 재정 자동화 포트폴리오

이 리포지토리는 Docker 기반 금융 애플리케이션 구축과 데이터베이스 백업, 보안 스캔, 문서 자동화 등을 아우르는 DevOps 워크플로우 예제를 제공합니다. 스크립트와 GitHub Actions를 통해 전체 환경을 자동화하며, 포트폴리오 및 학습 목적으로 활용할 수 있습니다.

## 디렉터리 구조
- **finance_app/** : 간단한 금융 애플리케이션을 실행하는 Docker 이미지(Dockerfile, start.sh 포함)
- **migrations/** : 초기 MySQL 스키마와 샘플 데이터를 삽입하는 `init.sql`
- **rust-example/** : "Hello, world!"를 출력하는 최소 Rust 예제
- **scripts/** : 컨테이너 설정, 데이터베이스 관리, 백업, 보안 스캔 등 자동화를 위한 쉘/파이썬 스크립트 모음
- **setup_guides/** : Docker, Go, MySQL, Python 설치 가이드
- **.github/workflows/** : 다양한 CI/CD 및 자동화 작업을 정의한 GitHub Actions 워크플로우

## 주요 스크립트 설명
- `setup_finance_docker.sh` : Docker 설치 후 finance_app 이미지를 빌드하고 주기적 백업을 위한 크론 작업을 설정합니다.
- `db_setup_and_backup.sh` : MySQL과 PostgreSQL을 설치하고 데이터베이스를 생성한 뒤 백업 디스크를 준비합니다.
- `full_setup.sh` : Docker 환경 설정부터 데이터베이스 준비, 샘플 트랜잭션 생성까지 전체 과정을 한 번에 실행합니다.
- `generate_shinhan_transactions.sh` : 지정한 개수만큼 Shinhan 은행 거래 데이터를 MySQL에 삽입합니다.
- `finance_db_tool.py` : SQLite 기반 고객 및 신용 거래 DB를 생성하고 더미 데이터를 관리합니다.
- 기타 `docker_backup.sh`, `optimize_disk.sh`, `generate_openai_token.sh` 등 보조 유틸리티 스크립트가 포함되어 있습니다.

## GitHub 워크플로우 요약
아래 표는 `.github/workflows` 디렉터리에 있는 모든 워크플로우와 주요 기능을 간략히 정리한 것입니다.

| 파일 | 기능 |
| --- | --- |
| Pages Auto Indexing.yml | Pages Auto Indexing 워크플로우 |
| Release.yml | Release 워크플로우 |
| ScorecardAnalysis.yml | ScorecardAnalysis 워크플로우 |
| TradingAgents.yml | TradingAgents 워크플로우 |
| airflow-healthcheck.yml | airflow healthcheck 워크플로우 |
| auto-backup.yml | auto backup 워크플로우 |
| auto-backup2.yml | auto backup2 워크플로우 |
| auto-rerun-all.yml | auto rerun all 워크플로우 |
| auto-transactions.yml | auto transactions 워크플로우 |
| auto_create_workflow.yml | auto_create_workflow 워크플로우 |
| backup-and-api-check.yml | backup and api check 워크플로우 |
| backup.yml | backup 워크플로우 |
| bankbackup.yml | bankbackup 워크플로우 |
| billing.yml | billing 워크플로우 |
| black-duck-security-scan-ci.yml | black duck security scan ci 워크플로우 |
| build_and_test.yml | build_and_test 워크플로우 |
| cash.yml | cash 워크플로우 |
| check-expensive-workflows.yml | check expensive workflows 워크플로우 |
| codeql.yml | codeql 워크플로우 |
| codespace-security-check.yml | codespace security check 워크플로우 |
| corescorecard.yml | corescorecard 워크플로우 |
| customer-image-docker.yml | customer image docker 워크플로우 |
| db.yml | db 워크플로우 |
| delete-failed-workflow-runs.yml | delete failed workflow runs 워크플로우 |
| delete_workflows.yml | delete_workflows 워크플로우 |
| dependabot-auto-merge.yml | dependabot auto merge 워크플로우 |
| dependabot-rescue.yml | dependabot rescue 워크플로우 |
| devskim.yml | devskim 워크플로우 |
| docker-backup-workflow.yml | docker backup workflow 워크플로우 |
| docker-backup.yml | docker backup 워크플로우 |
| docker-build-deploy.yml | docker build deploy 워크플로우 |
| docker-ci-cd.yml | docker ci cd 워크플로우 |
| docker-finance-build.yml | docker finance build 워크플로우 |
| docker-image.yml | docker image 워크플로우 |
| docker-setup.yml | docker setup 워크플로우 |
| download-security-regulations.yml | download security regulations 워크플로우 |
| encrypt-decrypt-tag-label.yml | encrypt decrypt tag label 워크플로우 |
| finance-backup-multi.yml | finance backup multi 워크플로우 |
| finance-docker.yml | finance docker 워크플로우 |
| finance-smart-backup1.yml | finance smart backup1 워크플로우 |
| full-finance-provenance-pages.yml | full finance provenance pages 워크플로우 |
| full-finance-scorecard1.yml | full finance scorecard1 워크플로우 |
| generate-customers.yml | generate customers 워크플로우 |
| generate-workflow-log06.yml | generate workflow log06 워크플로우 |
| generate_blog.yml | generate_blog 워크플로우 |
| generate_full_readme.yml | generate_full_readme 워크플로우 |
| gitlab-integration.yml | gitlab integration 워크플로우 |
| init-directory-structure.yml | init directory structure 워크플로우 |
| install-java-maven.yml | install java maven 워크플로우 |
| jekyll-gh-pages.yml | jekyll gh pages 워크플로우 |
| label-comment.yml | label comment 워크플로우 |
| label.yml | label 워크플로우 |
| ledger-generator.yml | ledger generator 워크플로우 |
| log-backup-container.yml | log backup container 워크플로우 |
| ml-setup.yml | ml setup 워크플로우 |
| mysql-integrated.yml | mysql integrated 워크플로우 |
| mysql-setup-and-query.yml | mysql setup and query 워크플로우 |
| mysql-setup.yml | mysql setup 워크플로우 |
| mysql-upgrade.yml | mysql upgrade 워크플로우 |
| osv-scan.yml | osv scan 워크플로우 |
| puppet-lint.yml | puppet lint 워크플로우 |
| python-ci.yml | python ci 워크플로우 |
| python-publish.yml | python publish 워크플로우 |
| release.yml | release 워크플로우 |
| release1.yml | release1 워크플로우 |
| retrigger-and-db-init.yml | retrigger and db init 워크플로우 |
| scorecard-analysis.ymltes.yml | scorecard analysis.ymltes 워크플로우 |
| setup-and-generate.yml | setup and generate 워크플로우 |
| setup-java-opa.yml | setup java opa 워크플로우 |
| setup-logistics-environment.yml | setup logistics environment 워크플로우 |
| sql-backup-and-migrate.yml | sql backup and migrate 워크플로우 |
| swift-backup.yml | swift backup 워크플로우 |
| test.yml | test 워크플로우 |
| tokencheck.yml | tokencheck 워크플로우 |
| transfer-log-backup.yml | transfer log backup 워크플로우 |
| transfer-log-backup1.yml | transfer log backup1 워크플로우 |
| transfer-log-infinite-backup.yml | transfer log infinite backup 워크플로우 |
| update_readme.yml | update_readme 워크플로우 |
| update_readme1.yml | update_readme1 워크플로우 |
| welcome.yml | welcome 워크플로우 |
| workflow-health-monitor.yml | workflow health monitor 워크플로우 |

## 사용 방법 예시
1. `scripts/setup_finance_docker.sh` 실행 후 컨테이너가 준비됩니다.
2. `scripts/db_setup_and_backup.sh`로 데이터베이스를 구축하고 백업 위치를 지정합니다.
3. GitHub에서 원하는 워크플로우를 수동(triggers: workflow_dispatch) 또는 스케줄 방식으로 실행해 전체 파이프라인을 체험합니다.

포트폴리오 목적으로 필요한 부분만 수정하여 활용하면 됩니다.
