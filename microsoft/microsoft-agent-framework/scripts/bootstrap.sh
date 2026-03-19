#!/usr/bin/env bash
set -euo pipefail

# Prepara entorno Python y dependencias para los demos.
# Requiere Python 3.11+ y acceso a un proveedor compatible con los ejemplos de Microsoft Learn.

python -m pip install --upgrade pip
python -m pip install "agent-framework[all] --pre" python-dotenv

echo "Listo. Ejecuta ./scripts/run_python_demo.sh"

