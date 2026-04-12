#!/usr/bin/env bash
set -euo pipefail
# Ejemplo ilustrativo: sustituye IMAGE por la etiqueta publicada en Docker Hub / ghcr según documentación vigente.

: "${OPENAI_API_KEY:?Exporta OPENAI_API_KEY o el proveedor que uses}"

IMAGE="${KUBEAGENTIC_IMAGE:-sudeshmu/kubeagentic:latest}"
CONFIG_DIR="$(cd "$(dirname "$0")/.." && pwd)/configs"

docker run --rm -it \
  -e OPENAI_API_KEY \
  -p 8000:8000 \
  -v "${CONFIG_DIR}:/config:ro" \
  "${IMAGE}" \
  kubeagentic serve --config /config/agent-minimal.yaml.example --port 8000
