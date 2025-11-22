#!/bin/bash
# Script para descargar los top 5 modelos LLM con Ollama

echo "📥 Descargando modelos LLM top 5..."

# Modelos 7B-8B (rápidos, caben en 12GB VRAM)
echo "1/5: Llama 3.1 8B..."
ollama pull llama3.1:8b

echo "2/5: Qwen2.5 8B..."
ollama pull qwen2.5:8b

echo "3/5: Mistral 7B..."
ollama pull mistral:7b

# Modelos especializados
echo "4/5: DeepSeek Coder 6.7B..."
ollama pull deepseek-coder:6.7b

# Modelo grande (requiere 24GB+ VRAM o quantización)
echo "5/5: Llama 3.1 70B (quantizado)..."
ollama pull llama3.1:70b

echo "✅ Todos los modelos descargados!"
echo ""
echo "Lista de modelos instalados:"
ollama list

