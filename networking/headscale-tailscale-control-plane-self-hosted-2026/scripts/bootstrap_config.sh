#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
VERSION="${HEADSCALE_VERSION:-0.25.1}"
CFG="${ROOT}/config/config.yaml"
mkdir -p "${ROOT}/config" "${ROOT}/data"
if [[ -f "${CFG}" ]]; then
  echo "Ya existe ${CFG}; no se sobrescribe. Elimínalo para regenerar."
  exit 0
fi
curl -fsSL "https://raw.githubusercontent.com/juanfont/headscale/v${VERSION}/config-example.yaml" -o "${CFG}"
echo "Descargado config-example oficial v${VERSION}."
echo "Edita server_url (HTTPS público) y listen_addr 0.0.0.0:8080 antes de docker compose up."
