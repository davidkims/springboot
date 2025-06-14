# Install Java, Maven, NetBackup CLI & Ledger Generation

Source: `.github/workflows/generate-workflow-log06.yml`

**Triggers**: workflow_dispatch, push

## Steps
- Checkout repository
- Create pom.xml with Shade Plugin via echo
- Create Java source via echo
- Generate install script via echo
- Install Java & Maven
- Install NetBackup CLI
- Configure & Create NetBackup Resources
- Build & Shade fat JAR
- Bulk-generate enterprise ledgers
