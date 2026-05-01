#!/usr/bin/env bash
set -euo pipefail

echo "# Resumen inventario"
echo
echo "- Nodos: $(python3 - <<'PY'
import yaml
print(len(yaml.safe_load(open('inventory/nodes.yaml'))['nodes']))
PY
)"
echo "- Servicios: $(python3 - <<'PY'
import yaml
print(len(yaml.safe_load(open('inventory/services.yaml'))['services']))
PY
)"
