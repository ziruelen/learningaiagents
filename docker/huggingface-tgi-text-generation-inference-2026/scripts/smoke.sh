#!/usr/bin/env bash
set -euo pipefail
HOST="${1:-127.0.0.1}"
PORT="${2:-8080}"
code=$(curl -s -o /dev/null -w "%{http_code}" "http://${HOST}:${PORT}/docs")
if [[ "$code" =~ ^(200|301|302)$ ]]; then
  echo "OK /docs HTTP $code"
  exit 0
fi
echo "FAIL /docs HTTP $code" >&2
exit 1
