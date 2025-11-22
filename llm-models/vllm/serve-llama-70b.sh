#!/bin/bash
# Script para servir Llama 3.1 70B con vLLM (quantizado para 24GB VRAM)

echo "🚀 Iniciando servidor vLLM con Llama 3.1 70B (quantizado Q4)..."

# Requiere: pip install vllm[quantization]
# O usar modelo pre-quantizado desde Hugging Face

vllm serve meta-llama/Llama-3.1-70B-Instruct \
  --tensor-parallel-size 1 \
  --host 0.0.0.0 \
  --port 8000 \
  --api-key "your-api-key-here" \
  --max-model-len 4096 \
  --quantization awq \
  --load-in-4bit

# Nota: Para RTX 4090 (24GB), usar quantización AWQ o GPTQ
# Para RTX 5090 (32GB), puede funcionar con INT4 sin quantización agresiva

