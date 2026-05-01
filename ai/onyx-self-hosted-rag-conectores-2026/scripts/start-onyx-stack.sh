#!/usr/bin/env bash
set -euo pipefail

cp -n configs/.env.example .env || true
docker compose up -d

echo "Onyx disponible en http://localhost:3000"
