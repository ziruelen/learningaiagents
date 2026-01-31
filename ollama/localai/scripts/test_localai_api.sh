#!/bin/bash
# Script para probar la API de LocalAI

LOCALAI_URL="${LOCALAI_URL:-http://localhost:8080}"

echo "🧪 Probando LocalAI API en $LOCALAI_URL"
echo ""

# 1. Verificar que LocalAI está corriendo
echo "1️⃣ Verificando que LocalAI está corriendo..."
if curl -s "$LOCALAI_URL/ready" > /dev/null; then
    echo "   ✅ LocalAI está corriendo"
else
    echo "   ❌ LocalAI no responde. ¿Está corriendo?"
    exit 1
fi

# 2. Listar modelos disponibles
echo ""
echo "2️⃣ Modelos disponibles:"
curl -s "$LOCALAI_URL/v1/models" | jq -r '.data[]?.id // "Ningún modelo configurado"'

# 3. Probar chat completion
echo ""
echo "3️⃣ Probando chat completion..."
MODEL=$(curl -s "$LOCALAI_URL/v1/models" | jq -r '.data[0].id // "gpt-4"')

if [ "$MODEL" = "null" ] || [ -z "$MODEL" ]; then
    echo "   ⚠️  No hay modelos configurados. Configura modelos en ./config/models.yaml"
    exit 1
fi

RESPONSE=$(curl -s -X POST "$LOCALAI_URL/v1/chat/completions" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "'"$MODEL"'",
    "messages": [
      {
        "role": "user",
        "content": "Hola, ¿cómo estás?"
      }
    ],
    "temperature": 0.7,
    "max_tokens": 100
  }')

if echo "$RESPONSE" | jq -e '.choices[0].message.content' > /dev/null 2>&1; then
    echo "   ✅ Respuesta recibida:"
    echo "$RESPONSE" | jq -r '.choices[0].message.content'
else
    echo "   ❌ Error en la respuesta:"
    echo "$RESPONSE" | jq '.'
fi

