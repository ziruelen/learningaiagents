#!/bin/bash
# Script para servir Llama 3.1 8B con vLLM

echo "🚀 Iniciando servidor vLLM con Llama 3.1 8B..."

vllm serve meta-llama/Llama-3.1-8B-Instruct \
  --tensor-parallel-size 1 \
  --host 0.0.0.0 \
  --port 8000 \
  --api-key "your-api-key-here" \
  --max-model-len 8192

# Uso:
# curl http://localhost:8000/v1/chat/completions \
#   -H "Authorization: Bearer your-api-key-here" \
#   -H "Content-Type: application/json" \
#   -d '{
#     "model": "meta-llama/Llama-3.1-8B-Instruct",
#     "messages": [{"role": "user", "content": "Hello!"}]
#   }'

