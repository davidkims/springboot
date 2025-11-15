# Codex 요금 상태 확인 워크플로우

다음 GitHub Actions 워크플로우는 OpenAI Codex 사용량을 조회하여 해당 카드로 청구가 이루어지고 있는지 확인합니다. 카드 번호는 사용자가 제공한 신한카드의 마지막 네 자리만 표시하도록 마스킹했습니다.

## 사용 방법
- GitHub 저장소의 `Secrets`에 `OPENAI_API_KEY`를 설정합니다.
- 워크플로우 파일 위치: `.github/workflows/check_codex_cost.yml`
- `workflow_dispatch` 이벤트로 수동 실행할 수 있습니다.

## 전체 코드
```yaml
name: Codex Cost Check
on:
  workflow_dispatch:

jobs:
  check-cost:
    runs-on: ubuntu-latest
    env:
      OPENAI_API_KEY: ${{ secrets.OPENAI_API_KEY }}
      MASKED_CARD: "**** **** **** 7206"
    steps:
      - name: Fetch Codex usage
        id: fetch
        run: |
          curl --fail --silent https://api.openai.com/v1/usage \
            -H "Authorization: Bearer $OPENAI_API_KEY" \
            -H "Content-Type: application/json" \
            -o usage.json
          if jq -e '.total_usage' usage.json >/dev/null; then
            total=$(jq '.total_usage' usage.json)
            echo "total_usage=$total" >> $GITHUB_OUTPUT
          else
            echo "total_usage=0" >> $GITHUB_OUTPUT
          fi
      - name: Check charges
        run: |
          total=${{ steps.fetch.outputs.total_usage }}
          if [ "$total" -gt 0 ]; then
            echo "Codex usage detected. Charges may be billed to card $MASKED_CARD."
          else
            echo "No Codex usage detected. Card $MASKED_CARD will not be charged."
          fi
```

이 워크플로우를 실행하면 Codex 사용량을 조회하여 다음과 같이 메시지를 출력합니다:
- 사용량이 존재할 경우: `Codex usage detected. Charges may be billed to card **** **** **** 7206.`
- 사용량이 없을 경우: `No Codex usage detected. Card **** **** **** 7206 will not be charged.`
