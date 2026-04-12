#!/usr/bin/env bash
set -euo pipefail
# Referencia: https://kagent.dev/docs/kagent/introduction/installation
# Requiere OPENAI_API_KEY en el entorno y kubectl apuntando al clúster correcto.

if [[ -z "${OPENAI_API_KEY:-}" ]]; then
  echo "Define OPENAI_API_KEY antes de ejecutar." >&2
  exit 1
fi

if ! command -v kagent >/dev/null 2>&1; then
  echo "Instala la CLI (brew install kagent o script get-kagent) y reintenta." >&2
  exit 1
fi

echo "Instalando kagent con perfil demo (puede tardar varios minutos)..."
kagent install --profile demo

echo "Para abrir la UI: kagent dashboard"
