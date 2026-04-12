#!/usr/bin/env bash
set -euo pipefail
URL="${1:-http://127.0.0.1:3000}"
code=$(curl -s -o /dev/null -w "%{http_code}" "$URL")
if [[ "$code" =~ ^(200|301|302)$ ]]; then
  echo "OK HTTP $code $URL"
  exit 0
fi
echo "FAIL HTTP $code $URL" >&2
exit 1
