#!/usr/bin/env bash
set -euo pipefail
# Referencia: https://kagent.dev/docs/kagent/introduction/installation
# CRDs + chart principal desde OCI GHCR.

if [[ -z "${OPENAI_API_KEY:-}" ]]; then
  echo "Define OPENAI_API_KEY antes de ejecutar." >&2
  exit 1
fi

NS="${KAGENT_NAMESPACE:-kagent}"

kubectl create namespace "${NS}" 2>/dev/null || true

helm upgrade --install kagent-crds oci://ghcr.io/kagent-dev/kagent/helm/kagent-crds \
  --namespace "${NS}"

helm upgrade --install kagent oci://ghcr.io/kagent-dev/kagent/helm/kagent \
  --namespace "${NS}" \
  --set providers.default=openAI \
  --set providers.openAI.apiKey="${OPENAI_API_KEY}"

echo "Hecho. UI: kubectl port-forward -n ${NS} svc/kagent-ui 8080:8080"
