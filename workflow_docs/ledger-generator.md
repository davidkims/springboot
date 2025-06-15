# 🦾 거래 자동화 - PDF 영수증 포함

Source: `.github/workflows/ledger-generator.yml`

**Triggers**: workflow_dispatch, push

## Steps
- 파일 검색
- 필드 클래스 거래 변동보 추가
- 📦 금융 수출입 거래 생성 컨테이너 실행
- 📤 수출입 거래 CSV 업로드
- 📦 결과 확인용 디렉토리 출력
- 📤 거래 CSV 업로드
- 📤 영수증 TXT 업로드
- 📤 영수증 PDF 업로드
