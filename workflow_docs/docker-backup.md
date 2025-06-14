# Install Java, Maven, NetBackup CLI & Ledger Generation with Migration to .github

Source: `.github/workflows/docker-backup.yml`

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
- Bulk-generate enterprise ledgers & customer list
- Migrate generated files into .github/migration and commit
- Create annotated Git tag
- Create GitHub Release
