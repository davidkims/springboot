#!/usr/bin/env python3
"""Delete failed GitHub workflow runs and disable their workflows.

This script interacts with the GitHub REST API to find completed workflow
runs that concluded with failure. For each such run it deletes the run and
then disables the workflow that produced it. A workflow is disabled only once
per execution to avoid redundant API calls.

Required environment variables:
- GITHUB_TOKEN: token with `actions:write` permission
- REPO: in the form "owner/repo"
"""

from __future__ import annotations

import os
import sys
import requests

API_ROOT = "https://api.github.com"
TOKEN = os.environ.get("GITHUB_TOKEN")
REPO = os.environ.get("REPO")

if not TOKEN or not REPO:
    print("GITHUB_TOKEN and REPO environment variables must be set", file=sys.stderr)
    sys.exit(1)

OWNER, REPO_NAME = REPO.split("/")

session = requests.Session()
session.headers.update(
    {
        "Authorization": f"token {TOKEN}",
        "Accept": "application/vnd.github+json",
    }
)

per_page = 50
page = 1
disabled_workflows: set[int] = set()

while True:
    resp = session.get(
        f"{API_ROOT}/repos/{OWNER}/{REPO_NAME}/actions/runs",
        params={"status": "completed", "per_page": per_page, "page": page},
        timeout=30,
    )
    resp.raise_for_status()
    runs = resp.json().get("workflow_runs", [])
    if not runs:
        break

    for run in runs:
        if run.get("conclusion") != "failure":
            continue

        run_id = run["id"]
        workflow_id = run["workflow_id"]

        del_resp = session.delete(
            f"{API_ROOT}/repos/{OWNER}/{REPO_NAME}/actions/runs/{run_id}", timeout=30
        )
        if del_resp.status_code == 204:
            print(f"Deleted failed run {run_id}")
        else:
            print(f"Failed to delete run {run_id}: {del_resp.status_code}", file=sys.stderr)

        if workflow_id not in disabled_workflows:
            dis_resp = session.put(
                f"{API_ROOT}/repos/{OWNER}/{REPO_NAME}/actions/workflows/{workflow_id}/disable",
                timeout=30,
            )
            if dis_resp.status_code == 204:
                print(f"Disabled workflow {workflow_id}")
                disabled_workflows.add(workflow_id)
            else:
                print(
                    f"Failed to disable workflow {workflow_id}: {dis_resp.status_code}",
                    file=sys.stderr,
                )

    page += 1
