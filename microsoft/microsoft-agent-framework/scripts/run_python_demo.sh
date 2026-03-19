#!/usr/bin/env bash
set -euo pipefail

echo "=== Microsoft Agent Framework (Python) - demo simple ==="

# Nota: debes definir estas variables para tu proveedor real (Azure OpenAI, OpenAI, Ollama, etc.)
# - AZURE_AI_PROJECT_ENDPOINT
# - AZURE_OPENAI_RESPONSES_DEPLOYMENT_NAME
#
# Si no usas Azure, cambia el client en src/python_agent_app/app.py

python -u src/python_agent_app/app.py

