# 🧾 결제 자동화 - PDF 영수증 포함

Source: `.github/workflows/cash.yml`

**Triggers**: workflow_dispatch, push

## Steps
- 파일 저장소 체크와워
- 파일 생성 - ledger.py 머지 목록
- 파일 목록 보기 (ls)
- 📤 거래 CSV 업로드
- 📤 영수증 TXT 업로드
- 📤 영수증 PDF 업로드
