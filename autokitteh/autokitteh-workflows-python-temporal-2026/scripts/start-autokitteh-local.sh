#!/usr/bin/env bash
set -euo pipefail

echo "[1/3] Verificando docker..."
docker --version >/dev/null

echo "[2/3] Levantando Temporal local..."
docker run -d --name temporal-dev \
  -p 7233:7233 \
  temporalio/auto-setup:1.25.0 >/dev/null || true

echo "[3/3] Stack listo. Configura AutoKitteh según docs oficiales."
