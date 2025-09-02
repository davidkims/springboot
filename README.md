## Updated README at Thu Aug 21 13:08:31 UTC 2025

This README was last updated by a GitHub Actions workflow.

### Repository Analysis
Current Python version: Python 3.13.7
Number of Python files: 15
Number of Java files: 0

### Provenance Cleanup

The repository includes a utility script at `scripts/remove_provenance_files.py` that scans for files or directories whose names contain `provenance`.

Run the script in dry-run mode to list matching paths:

```
python scripts/remove_provenance_files.py --root .
```

Add the `--delete` flag to remove the files instead of just listing them:

```
python scripts/remove_provenance_files.py --root . --delete
```


### Setup Guides

- [Docker](docker/README.md)
- [Java](java/README.md)
- [Maven](maven/README.md)
- [Spring Boot](springboot/README.md)
