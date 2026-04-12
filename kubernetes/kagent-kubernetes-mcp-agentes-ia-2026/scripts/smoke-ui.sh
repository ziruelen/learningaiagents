#!/usr/bin/env bash
set -euo pipefail
NS="${KAGENT_NAMESPACE:-kagent}"
echo "Port-forward a kagent-ui en 8080 (Ctrl+C para salir)..."
kubectl port-forward -n "${NS}" svc/kagent-ui 8080:8080
