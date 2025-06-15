# Repository Guidelines for AI Agents

This file provides instructions for Codex agents working on this repository.

## Commit Messages
- Use conventional commit style such as `feat:`, `fix:`, `docs:`, `chore:`.
- Write messages in English.

## Rust Code
- Run `cargo fmt -- --check` after modifying any files under `rust-example`.
- Run `cargo test` if tests are added.

## Shell Scripts
- Run `shellcheck` on modified `.sh` files if available.

## Pull Request Description
- Summarize changes in English under **Summary**.
- Mention the result of checks under **Testing**.

## Server Agents
These workflows manage multiple server environments. Follow these instructions for each agent:

### MySQL
- Use `mysql:8.0` Docker images when launching ephemeral containers.
- Provide `MYSQL_ROOT_PASSWORD`, `MYSQL_DATABASE`, `MYSQL_USER` and `MYSQL_PASSWORD`.
- Wait at least 30 seconds after the container starts before running SQL commands.
- Use `mysqldump --no-tablespaces` for database backups.

### PostgreSQL
- The default administrative user is `postgres`.
- Create databases and tables with `psql`.
- Log operations to a PostgreSQL table and to `${KAFKA_LOG}` for debugging.
- Compress backup files with `tar -czf` before uploading artifacts.

### MongoDB
- Add the MongoDB 6.0 GPG key from `https://www.mongodb.org/static/pgp/server-6.0.asc`.
- Configure the apt repository for the detected Ubuntu codename.
- Enable and start the `mongod` service with `systemctl`.

### Oracle
- Run Oracle XE using `quay.io/license/oracle-xe:latest` docker image.
- Expose port `1521` on the host.

### Workflow Tools
- Use Apache Airflow 2.6, Camunda BPM 7.19, and Salesforce CLI for workflow automation.
- Install them as shown in `.github/workflows/setup-logistics-environment.yml`.

### Common Notes
- All jobs run on `ubuntu-latest`.
- Store credentials in environment variables rather than in the repository.
- Stop any running containers at the end of each job to free resources.

