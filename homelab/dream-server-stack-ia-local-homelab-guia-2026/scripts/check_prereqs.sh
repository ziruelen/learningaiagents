#!/usr/bin/env bash
set -euo pipefail
echo "== Docker =="
command -v docker >/dev/null && docker version --format '{{.Server.Version}}' || { echo "Falta docker"; exit 1; }
docker compose version >/dev/null 2>&1 || { echo "Falta docker compose v2"; exit 1; }
echo "== NVIDIA (opcional) =="
if command -v nvidia-smi >/dev/null; then nvidia-smi --query-gpu=name,memory.total --format=csv,noheader; else echo "nvidia-smi no instalado (omitir si sin GPU NVIDIA)"; fi
echo "OK prerequisitos básicos."
