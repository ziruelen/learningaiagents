#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"
python3 -m venv .venv
# shellcheck disable=SC1091
source .venv/bin/activate
python -m pip install -U pip wheel
# Pin explícito recomendado en entornos reproducibles (ajusta versiones):
pip install "openllm==0.6.30"
echo "OK. Activa con: source $ROOT/.venv/bin/activate"
