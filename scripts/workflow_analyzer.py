#!/usr/bin/env python3
"""Analyze GitHub workflows and trigger Dependabot updates.

This utility helps investigate the latest run of each GitHub Actions workflow
in a repository and provides a command to trigger Dependabot update jobs for
each configured ecosystem. It uses the GitHub REST API.

Environment variables:
- GITHUB_TOKEN: Personal access token with `repo` and `workflow` scopes.
- REPO: Repository in the form "owner/repo". Defaults to "davidkims/springboot".
"""

from __future__ import annotations

import argparse
import os
import sys
from typing import Iterable

import requests

API_ROOT = "https://api.github.com"
TOKEN = os.environ.get("GITHUB_TOKEN")
REPO = os.environ.get("REPO", "davidkims/springboot")

if not TOKEN:
    print("GITHUB_TOKEN environment variable must be set", file=sys.stderr)
    sys.exit(1)

SESSION = requests.Session()
SESSION.headers.update(
    {
        "Authorization": f"token {TOKEN}",
        "Accept": "application/vnd.github+json",
    }
)


def fetch_json(url: str, **kwargs) -> dict:
    """GET helper returning JSON with error handling."""
    resp = SESSION.get(url, timeout=30, **kwargs)
    resp.raise_for_status()
    return resp.json()


def list_workflows() -> Iterable[dict]:
    """Return an iterable of workflow metadata objects."""
    data = fetch_json(f"{API_ROOT}/repos/{REPO}/actions/workflows")
    return data.get("workflows", [])


def analyze_workflows() -> None:
    """Print the last run status for each workflow and failing step if any."""
    for wf in list_workflows():
        wf_id = wf.get("id")
        wf_name = wf.get("name")
        runs_url = f"{API_ROOT}/repos/{REPO}/actions/workflows/{wf_id}/runs"
        runs = fetch_json(runs_url, params={"per_page": 1}).get("workflow_runs", [])
        if not runs:
            print(f"{wf_name}: no runs")
            continue
        run = runs[0]
        conclusion = run.get("conclusion")
        run_id = run.get("id")
        print(f"{wf_name}: {conclusion}")
        if conclusion != "failure":
            continue
        jobs_url = f"{API_ROOT}/repos/{REPO}/actions/runs/{run_id}/jobs"
        jobs = fetch_json(jobs_url).get("jobs", [])
        for job in jobs:
            for step in job.get("steps", []):
                if step.get("conclusion") == "failure":
                    print(f"  failing step: {step.get('name')}")
                    break
            else:
                continue
            break


def trigger_dependabot_update(ecosystem: str, directory: str) -> None:
    """Trigger a Dependabot update job for the given ecosystem and directory."""
    url = f"{API_ROOT}/repos/{REPO}/dependabot/updates"
    payload = {"package-ecosystem": ecosystem, "directory": directory}
    resp = SESSION.post(url, json=payload, timeout=30)
    if resp.status_code == 201:
        print(f"Triggered Dependabot update for {ecosystem} ({directory})")
    else:
        print(
            f"Failed to trigger update for {ecosystem} ({directory}): {resp.status_code}",
            file=sys.stderr,
        )
        print(resp.text)


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    sub = parser.add_subparsers(dest="command", required=True)

    sub.add_parser("analyze", help="Analyze latest workflow runs")

    upd = sub.add_parser("update", help="Trigger Dependabot update")
    upd.add_argument("ecosystem", help="package ecosystem, e.g. pip")
    upd.add_argument("directory", help="directory where the manifest lives")

    args = parser.parse_args()
    if args.command == "analyze":
        analyze_workflows()
    elif args.command == "update":
        trigger_dependabot_update(args.ecosystem, args.directory)


if __name__ == "__main__":
    main()
