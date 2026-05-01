#!/usr/bin/env bash
set -euo pipefail

curl -fsS "http://localhost:9090/api/v1/targets" | jq -r '.status'
