# Repo Analysis and README Update

Source: `.github/workflows/update_readme.yml`

**Triggers**: push, schedule, workflow_dispatch

## Steps
- Checkout repository
- Set up Python (for scripting)
- Install Python dependencies (if needed)
- Generate updated README.md content
- Install yq (for YAML parsing in README generation)
- Configure Git for automated commit
- Commit and Push changes
