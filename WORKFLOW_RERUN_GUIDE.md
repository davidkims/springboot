# Workflow Rerun Guide

This repository contains a GitHub Actions workflow that automates the creation of a GitHub Release whenever a tag beginning with `v` is pushed to the repository. The workflow file is located at:

```
.github/workflows/Release.yml
```

## Workflow Overview

The `Create GitHub Release` workflow performs the following steps:

1. **Checkout repository** – Fetches the repository code.
2. **Install Swift Toolchain** – Sets up Swift 5.10 for building the project.
3. **Get Project Name** – Derives the executable name from the repository name.
4. **Build Release Executable** – Builds the Swift CLI in release mode.
5. **Prepare Release Assets** – Packages the built executable into a zip file and prepares it for release.
6. **Get Release Notes (Optional)** – Generates simple release notes.
7. **Create Release** – Uses the `softprops/action-gh-release` action to publish the release with the prepared assets.

## Rerunning the Workflow

You can rerun this workflow in two ways:

### GitHub Web UI
1. Navigate to the **Actions** tab of the repository.
2. Select the run you want to rerun.
3. Click **Re-run jobs**.

### GitHub CLI
Use the GitHub CLI to rerun a specific run or manually trigger the workflow:

```bash
# Rerun a specific run by ID
gh run rerun <run-id>

# Trigger the workflow for a tag
gh workflow run Release.yml --ref <tag>
```

Replace `<run-id>` with the identifier of the workflow run and `<tag>` with the git tag (e.g., `v1.0.0`).

This guide provides a quick reference for understanding the workflow steps and how to rerun the workflow when needed.
