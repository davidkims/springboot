# Security Policy

## 1. 소개
이 저장소의 보안 정책 및 절차를 명시합니다.

## 2. 취약점 신고
- 이메일: security@example.com  
- 신고 양식: [ISSUE_TEMPLATE/security_report.md](.github/ISSUE_TEMPLATE/security_report.md) 참조

## 3. 패치 및 릴리스 절차
1. 커밋 브랜치명: `fix/security-YYYYMMDD`
2. PR 생성 시 태그: `security`, `critical`
3. 리뷰: 최소 2인 이상
4. 긴급 패치: `hotfix/security-YYYYMMDD` 브랜치

## 4. 암호화 방침
- **전송 중**: TLS 1.2 이상
- **저장 시**: AES-256
- 키 관리: AWS KMS 또는 HashiCorp Vault

## 5. 접근 통제
- 최소 권한 원칙
- IAM Role 기반 접근
- 정기적 권한 검토(분기별)

## 6. 로그 및 모니터링
- 모든 인증 시도와 주요 이벤트 로깅
- ELK/CloudWatch 연동
- 이상 징후 탐지: 주 1회 자동 리포트

## 7. 백업 및 복구
- DB: 일일 백업, 7일 보관
- 파일: 주간 스냅샷, 4주 보관
- 복구 테스트: 분기별 1회

## 8. 표준 및 프레임워크
- ISO/IEC 27001
- NIST SP 800-53
- OWASP Top 10

---
