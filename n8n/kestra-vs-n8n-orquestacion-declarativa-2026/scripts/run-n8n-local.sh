#!/usr/bin/env bash
set -euo pipefail

docker run --rm -it \
  -p 5678:5678 \
  -e N8N_HOST=localhost \
  n8nio/n8n:latest
