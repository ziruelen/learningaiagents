#!/usr/bin/env bash
set -euo pipefail

python3 -m pip install --upgrade aider-chat

echo "Asegúrate de tener Ollama levantado y el modelo descargado."
echo "Ejemplo: ollama pull qwen2.5-coder:14b"
echo "Uso: aider --model ollama_chat/qwen2.5-coder:14b"
