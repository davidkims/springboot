# Download Security Regulations

Source: `.github/workflows/download-security-regulations.yml`

**Triggers**: schedule, workflow_dispatch

## Steps
- Checkout repository (full history)
- Prepare regulations directory
- Download CVSS v3.1 Specification
- Download CVE Modified Feed
- Download ISRM Guidelines (NIST SP 800-30 Rev.1)
- Sync with remote main
- Commit & push updates
