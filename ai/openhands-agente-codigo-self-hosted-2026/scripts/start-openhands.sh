#!/usr/bin/env bash
set -euo pipefail

BASE_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$BASE_DIR"

cp -n configs/.env.example .env || true

docker run --rm -it \
  --name openhands-local \
  --env-file .env \
  -v "$(pwd):/workspace" \
  allhandsai/openhands:latest
