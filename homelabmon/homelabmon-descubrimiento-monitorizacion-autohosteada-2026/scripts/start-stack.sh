#!/usr/bin/env bash
set -euo pipefail

docker compose up -d

echo "Prometheus: http://localhost:9090"
echo "Grafana: http://localhost:3000"
