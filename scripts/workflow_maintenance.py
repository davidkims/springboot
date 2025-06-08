import os
import requests
import datetime
from pathlib import Path

GITHUB_TOKEN = os.environ.get('GITHUB_TOKEN')
REPO_OWNER = os.environ.get('REPO_OWNER')
REPO_NAME = os.environ.get('REPO_NAME')

API_URL = f"https://api.github.com/repos/{REPO_OWNER}/{REPO_NAME}"
HEADERS = {
    "Authorization": f"token {GITHUB_TOKEN}",
    "Accept": "application/vnd.github.v3+json"
}


def create_tag_and_label():
    tag_name = datetime.datetime.utcnow().strftime("auto-%Y%m%d%H%M%S")

    # Create git tag pointing at main
    ref_resp = requests.get(f"{API_URL}/git/ref/heads/main", headers=HEADERS)
    if ref_resp.ok:
        sha = ref_resp.json().get("object", {}).get("sha")
        requests.post(
            f"{API_URL}/git/refs",
            headers=HEADERS,
            json={"ref": f"refs/tags/{tag_name}", "sha": sha}
        )

    # Create issue label with same name if it does not exist
    requests.post(
        f"{API_URL}/labels",
        headers=HEADERS,
        json={"name": tag_name, "color": "0e8a16"}
    )

    return tag_name


def disable_and_delete_failed_runs():
    runs_resp = requests.get(f"{API_URL}/actions/runs?per_page=100", headers=HEADERS)
    if not runs_resp.ok:
        print("Unable to fetch workflow runs")
        return

    for run in runs_resp.json().get("workflow_runs", []):
        if run.get("conclusion") == "failure":
            workflow_id = run.get("workflow_id")
            run_id = run.get("id")
            # disable the workflow
            requests.put(
                f"{API_URL}/actions/workflows/{workflow_id}/disable",
                headers=HEADERS
            )
            # delete the failed run
            requests.delete(
                f"{API_URL}/actions/runs/{run_id}",
                headers=HEADERS
            )


def main():
    if not GITHUB_TOKEN:
        print("GITHUB_TOKEN not provided")
        return
    create_tag_and_label()
    disable_and_delete_failed_runs()


if __name__ == "__main__":
    main()
