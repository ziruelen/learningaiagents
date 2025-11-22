#!/bin/bash
# Script para medir velocidad de inferencia de modelos Ollama

MODEL=${1:-"llama3.1:8b"}
PROMPT="Escribe un párrafo sobre inteligencia artificial."

echo "⏱️  Benchmarking modelo: $MODEL"
echo "Prompt: $PROMPT"
echo ""

# Medir tiempo de respuesta
time ollama run $MODEL "$PROMPT" > /dev/null

echo ""
echo "💡 Para medir tokens/segundo, usa la API:"
echo "curl http://localhost:11434/api/generate -d '{\"model\": \"$MODEL\", \"prompt\": \"$PROMPT\", \"stream\": false}' | jq '.eval_count / .eval_duration'"

