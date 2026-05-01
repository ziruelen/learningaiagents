#!/usr/bin/env bash
set -euo pipefail

BASE_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$BASE_DIR/configs"

cp -n .env.example .env || true
docker compose -f docker-compose.langfuse.yml up -d

echo "Langfuse disponible en http://localhost:3000"
