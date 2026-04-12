#!/usr/bin/env bash
set -euo pipefail
# Comandos de referencia (no modifica el clúster). Ajusta versión de Python según README oficial.

python3 -m venv .venv-kubeagentic
# shellcheck source=/dev/null
source .venv-kubeagentic/bin/activate
pip install --upgrade pip wheel
pip install "kubeagentic"

echo "Instalación lista. Siguiente paso típico (consulta README del proyecto):"
echo "  kubeagentic serve --config agent.yaml --port 8000"
echo "Comprueba /health y /metrics en la versión que hayas instalado."
