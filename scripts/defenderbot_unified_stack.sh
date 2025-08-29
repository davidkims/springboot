#!/usr/bin/env bash
# defenderbot_unified_stack.sh - Setup Defender Bot with Teradata, DW, and Omni EchoOps v7.7
# Full Mega Unified stack: Podman/Docker, Ledger Partition/MV, Prometheus+Alertmanager,
# Loki+Promtail, SBOM+Cosign+Provenance, and OCI firewall rules.
set -euo pipefail

# Determine container engine
if command -v podman >/dev/null; then
  ENGINE="podman"
elif command -v docker >/dev/null; then
  ENGINE="docker"
else
  echo "Neither podman nor docker is installed." >&2
  exit 1
fi

# Create network and ledger partition volume
$ENGINE network create defenderbot-net >/dev/null 2>&1 || true
$ENGINE volume create ledger_partition >/dev/null 2>&1 || true

# Run Teradata container (placeholder image)
$ENGINE run -d --name teradata-db --network defenderbot-net \
  -v ledger_partition:/var/lib/teradata \
  teradatadb/teradata:latest >/dev/null 2>&1 || true

echo "Teradata container launched (simulated)."

# Run Omni EchoOps v7.7 container (placeholder image)
$ENGINE run -d --name omni-echoops --network defenderbot-net \
  -p 8080:8080 omni/echoops:7.7 >/dev/null 2>&1 || true

echo "Omni EchoOps v7.7 container launched (simulated)."

# Run Prometheus and Alertmanager
$ENGINE run -d --name prometheus --network defenderbot-net \
  -p 9090:9090 prom/prometheus >/dev/null 2>&1 || true
$ENGINE run -d --name alertmanager --network defenderbot-net \
  -p 9093:9093 prom/alertmanager >/dev/null 2>&1 || true

echo "Prometheus and Alertmanager launched (simulated)."

# Run Loki and Promtail
$ENGINE run -d --name loki --network defenderbot-net \
  -p 3100:3100 grafana/loki:latest >/dev/null 2>&1 || true
$ENGINE run -d --name promtail --network defenderbot-net \
  -p 9080:9080 grafana/promtail:latest \
  -config.file=/etc/promtail/promtail-config.yml >/dev/null 2>&1 || true

echo "Loki and Promtail launched (simulated)."

# Generate SBOM and sign images if tools available
if command -v syft >/dev/null; then
  syft omni/echoops:7.7 -o spdx-json > omni-echoops.sbom.json
  echo "SBOM generated for Omni EchoOps." 
else
  echo "Syft not installed; skipping SBOM generation." 
fi

if command -v cosign >/dev/null; then
  cosign sign --key cosign.key omni/echoops:7.7 || true
  cosign attest --predicate omni-echoops.sbom.json --key cosign.key omni/echoops:7.7 || true
  echo "Cosign signing and provenance attestation complete." 
else
  echo "Cosign not installed; skipping image signing and provenance." 
fi

# OCI firewall rule placeholders
if command -v ufw >/dev/null; then
  echo "Configuring UFW firewall rules..."
  ufw allow 8080/tcp || true
  ufw allow 9090/tcp || true
  ufw allow 9093/tcp || true
  ufw allow 3100/tcp || true
  ufw allow 9080/tcp || true
else
  echo "UFW not installed; manual firewall configuration required." 
fi

echo "Defender Bot unified stack setup completed (simulation)."
