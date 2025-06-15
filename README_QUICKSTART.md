# GitHub Actions 빠른 시작 (5분 완성)

이 문서는 GitHub Actions의 핵심 기능을 5분 만에 경험해 볼 수 있는 가이드입니다.

## 목차

1. [소개](#소개)  
2. [워크플로 템플릿 사용](#워크플로-템플릿-사용)  
3. [필수 조건](#필수-조건)  
4. [첫 번째 워크플로 만들기](#첫-번째-워크플로-만들기)  
5. [워크플로 결과 보기](#워크플로-결과-보기)  
6. [다음 단계](#다음-단계)  

---

## 소개

GitHub Actions는 리포지토리에 변경을 푸시할 때마다 테스트를 실행하거나, 병합된 PR을 프로덕션에 배포하는 등 빌드·테스트·배포 파이프라인을 자동화할 수 있는 CI/CD 플랫폼입니다.

---

## 워크플로 템플릿 사용

- GitHub의 `actions/starter-workflows` 리포지토리에서 미리 구성된 템플릿을 가져올 수 있습니다.  
- Node.js, Python, Docker 등 다양한 템플릿이 준비되어 있습니다.  
- 그대로 사용하거나 필요한 부분만 수정해 빠르게 시작하세요.

---

## 필수 조건

1. GitHub 사용 기본 지식  
2. 워크플로를 추가할 리포지토리  
3. GitHub Actions 사용 권한  

---

## 첫 번째 워크플로 만들기

1. 리포지토리 루트에 **`.github/workflows/github-actions-demo.yml`** 파일을 생성합니다.  
2. 아래 YAML을 복사·붙여넣기 후 커밋하세요.

```yaml
name: GitHub Actions Demo
run-name: ${{ github.actor }} is testing out GitHub Actions 🚀
on: [push]

jobs:
  Explore-GitHub-Actions:
    runs-on: ubuntu-latest
    steps:
      - run: echo "🎉 This job was automatically triggered by a ${{ github.event_name }} event."
      - run: echo "🐧 Running on ${{ runner.os }} hosted by GitHub!"
      - run: echo "🔎 Branch: ${{ github.ref }}, Repo: ${{ github.repository }}."
      - name: Check out code
        uses: actions/checkout@v4
      - run: echo "💡 Code has been cloned to the runner."
      - name: List repository files
        run: |
          ls ${{ github.workspace }}
      - run: echo "🍏 Job status: ${{ job.status }}."
