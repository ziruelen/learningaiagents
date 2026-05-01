#!/usr/bin/env bash
set -euo pipefail

python3 - <<'PY'
import yaml
from pathlib import Path

base = Path('inventory')
required = ['nodes.yaml', 'network.yaml', 'services.yaml']

for name in required:
    path = base / name
    with open(path, 'r', encoding='utf-8') as f:
        yaml.safe_load(f)
print('Inventario YAML válido')
PY
