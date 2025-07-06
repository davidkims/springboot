name: 📓 포트폴리오 + 워크플로 통계로 README & SECURITY 업데이트

on:
  schedule:
    - cron: '*/1 * * * *'  # 매분 실행
  workflow_dispatch:

permissions:
  contents: write
  actions: write   # 워크플로우 재실행 권한

jobs:
  update_docs:
    runs-on: ubuntu-latest
    env:
      GH_TOKEN: ${{ secrets.GITHUB_TOKEN }}

    steps:
      - name: 📅 Checkout Repository
        uses: actions/checkout@v4
        with:
          fetch-depth: 0

      - name: 🔧 시스템 패키지, GitHub CLI, jq 설치
        run: |
          echo "[🔧] 시스템 패키지, GitHub CLI, jq 최신화 중..."
          sudo apt-get update -y && sudo apt-get upgrade -y
          sudo apt-get install -y gh jq
          gh --version
          jq --version

      - name: 🔄 실패한 워크플로우 정상 종료될 때까지 무한 재실행 (Rate-limit 대비)
        run: |
          echo "[🔄] 실패한 워크플로우 정상 종료될 때까지 무한 재실행 중..."
          for f in .github/workflows/*.yml; do
            FILENAME=$(basename "$f")
            echo "[🔍] 워크플로우: $FILENAME"
            while true; do
              RES=$(gh run list --workflow="$FILENAME" --limit 1 --json databaseId,conclusion 2>&1)
              if echo "$RES" | grep -q "API rate limit"; then
                echo "[⚠️] API rate limit 발생. 60초 후 재시도..."
                sleep 60
                continue
              fi
              RUN_ID=$(echo "$RES" | jq -r '.[0].databaseId')
              CONC=$(echo "$RES" | jq -r '.[0].conclusion')
              if [ "$CONC" != "success" ]; then
                echo "[🔄] Run ID $RUN_ID 재실행 시도"
                RR=$(gh run rerun "$RUN_ID" 2>&1)
                if echo "$RR" | grep -q "API rate limit"; then
                  echo "[⚠️] rerun API rate limit 발생. 60초 후 재시도..."
                  sleep 60
                  continue
                fi
                echo "[ℹ️] 재실행 요청 완료. 60초 대기 후 상태 재확인..."
                sleep 60
                continue
              else
                echo "[✅] 워크플로우 $FILENAME 마지막 실행 성공"
                break
              fi
            done
          done

      - name: 📋 Ensure .tmp Directory
        run: |
          echo "[📁] .tmp 디렉토리 생성 확인"
          mkdir -p .tmp

      - name: 📊 워크플로우 통계 수집
        run: |
          echo "[📊] 워크플로우 통계 수집 중..."
          OUTPUT_FILE=".tmp/workflows.md"
          echo "## ⚙️ GitHub Actions 워크플로우 목록 및 통계" > "$OUTPUT_FILE"
          echo "" >> "$OUTPUT_FILE"
          echo "| 워크플로우 이름 | 실행 수 | 성공 수 | 실패 수 | 성공률 |" >> "$OUTPUT_FILE"
          echo "|----------------|--------:|--------:|--------:|--------:|" >> "$OUTPUT_FILE"
          for f in .github/workflows/*.yml; do
            NAME=$(grep '^name:' "$f" | head -n1 | cut -d ':' -f2- | xargs)
            FILENAME=$(basename "$f")
            RUNS=$(gh run list --workflow="$FILENAME" --limit 100 --json conclusion -q '.[] | .conclusion' || echo "")
            TOTAL=$(echo "$RUNS" | wc -l)
            SUCCESS=$(echo "$RUNS" | grep -c "success" || true)
            FAILURE=$((TOTAL - SUCCESS))
            if [ "$TOTAL" -gt 0 ]; then
              RATE=$(awk "BEGIN {printf \"%.1f\", ($SUCCESS/$TOTAL)*100}")
            else
              RATE="N/A"
            fi
            echo "| $NAME | $TOTAL | $SUCCESS | $FAILURE | $RATE% |" >> "$OUTPUT_FILE"
          done
          cat "$OUTPUT_FILE"

      - name: 📄 Generate README.md
        run: |
          echo "[📄] README.md 생성 중..."
          TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S KST')
          REPO="${{ github.repository }}"
          BRANCH="${{ github.ref_name }}"
          {
            echo "# 👨‍💻 김병권 포토포리오"
            echo ""
            for f in .github/workflows/*.yml; do
              BADGE_NAME=$(basename "$f")
              echo "[![${BADGE_NAME}](https://github.com/${REPO}/actions/workflows/${BADGE_NAME}/badge.svg)](https://github.com/${REPO}/actions/workflows/${BADGE_NAME})"
            done
            echo ""
            echo "자동으로 관리되는 프로젝트입니다. 매분 간격으로 업데이트됩니다."
            echo ""
            echo "## 🤖 디바이저 소개"
            echo "- 이름: 김병권"
            echo "- 이메일1: byungkwonkim95@gmail.com"
            echo "- 이메일2: kwonny1302@gmail.com"
            echo "- 전문 범위: 백업, GitHub Actions 자동화, DevOps"
            echo "- 스택: Python, Java, Spring Boot, Docker, PostgreSQL, MySQL"
            echo "- 자기개발 메시지: https://www.youtube.com/watch?v=G8lvQRALa6s"
            echo ""
            echo "## 📅 마지막 업데이트"
            echo "- $TIMESTAMP"
            echo ""
            echo "## ✅ 현재 브랜치"
            echo "- $BRANCH"
            echo ""
            echo "## 🔧 빌드 방식 배지"
            echo "![Build](https://github.com/${REPO}/actions/workflows/generate_full_readme.yml/badge.svg)"
            echo ""
            cat .tmp/workflows.md
          } > README.md

      - name: 🛡️ Generate SECURITY.md
        run: |
          echo "[🛡️] SECURITY.md 생성 중..."
          cat << 'EOF' > SECURITY.md
          # Security Policy

          ## Supported Versions

          | Version | Supported          |
          | ------- | ------------------ |
          | 5.1.x   | :white_check_mark: |
          | 5.0.x   | :x:                |
          | 4.0.x   | :white_check_mark: |
          | < 4.0   | :x:                |

          ## Reporting a Vulnerability

          Use this section to tell people how to report a vulnerability.
          Tell them where to go, how often they can expect to get an update on a
          reported vulnerability, what to expect if the vulnerability is accepted or
          declined, etc.
          EOF

      - name: 🔁 Commit / Push or PR
        run: |
          echo "[🔁] 변경사항 확인 및 Git 설정"
          git config user.name "github-actions[bot]"
          git config user.email "41898282+github-actions[bot]@users.noreply.github.com"

          if git diff --exit-code --quiet README.md SECURITY.md; then
            echo "[⏭️] 변경사항 없음"
            exit 0
          fi

          echo "[✅] 변경사항 감지됨"
          git stash --include-untracked
          git pull --rebase origin main || echo "[⚠️] rebase 실패"
          git stash pop || echo "[⚠️] stash pop 실패"
          git add README.md SECURITY.md
          git commit -m "문서: README & SECURITY 업데이트 [skip ci]"

          if git push origin HEAD:main; then
            echo "[🚀] 정상 Push 완료"
          else
            echo "[⚠️] 직접 Push 권한 없음 — PR 생성 시도"
            BRANCH="update-docs-$(date +%s)"
            git checkout -b "$BRANCH"
            git push origin "$BRANCH"
            gh pr create \
              --title "문서: README & SECURITY 업데이트" \
              --body "자동 생성된 PR입니다." \
              --base main \
              --label documentation,auto-generated \
              || echo "[⚠️] 라벨 생성 실패"
            echo "[📦] PR 생성 완료"
          fi
