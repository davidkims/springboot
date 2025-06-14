# Generate and Backup Corporate Banking Data with Secure ZIP and Conditional OCI Upload

Source: `.github/workflows/docker-ci-cd.yml`

**Triggers**: workflow_dispatch, push

## Steps
- 📦 Checkout Repository
- 🐍 Set up Python
- 📥 Install Required Python Packages
- 📄 Generate YAML Configuration
- 🧪 Validate YAML File via echo-generated script
- 📦 Simulate Data Extraction
- 🔐 Generate or Use Backup Password & Encrypt Backup File
- 🖼️ Generate Credit & Debit Card Transaction Images via echo-generated script
- ☁ Install OCI CLI
- ☁ Configure & Upload to OCI Object Storage (Conditional)
- ☑️ NetBackup CLI 실행 (예시)
- ✅ 완료 메시지
