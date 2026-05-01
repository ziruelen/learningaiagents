#!/usr/bin/env bash
set -euo pipefail

docker run --rm -it \
  -p 8080:8080 \
  kestra/kestra:latest server local
