#!/usr/bin/env bash
# Instalación AutoGen Studio en venv (homelab)
set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
VENV_DIR="${ROOT_DIR}/.venv"

echo "Creando venv en ${VENV_DIR}..."
python3 -m venv "$VENV_DIR"
source "${VENV_DIR}/bin/activate"
pip install -U pip
pip install -U autogenstudio
echo "Listo. Activa con: source ${VENV_DIR}/bin/activate"
echo "Arranca UI: autogenstudio ui --port 8081"
