#!/usr/bin/env bash
set -euo pipefail

curl -fsS http://localhost:3000/ >/dev/null

echo "OK: interfaz Onyx responde"
