#!/bin/bash
# Script para configurar integración Open WebUI + n8n
# Uso: ./setup-integration-n8n.sh

set -e

echo "🔧 Configurando integración Open WebUI + n8n..."

# Obtener API key de Open WebUI
read -p "Introduce tu API key de Open WebUI (Settings → API Keys): " API_KEY

# URL del webhook de n8n
read -p "Introduce la URL del webhook de n8n: " WEBHOOK_URL

# Crear archivo de configuración
cat > n8n-integration.env <<EOF
# Configuración de integración n8n
OPEN_WEBUI_API_KEY=${API_KEY}
OPEN_WEBUI_URL=http://localhost:3000
N8N_WEBHOOK_URL=${WEBHOOK_URL}
EOF

echo "✅ Configuración guardada en n8n-integration.env"

# Ejemplo de uso con curl
cat > send-to-n8n-example.sh <<'EXAMPLE'
#!/bin/bash
# Ejemplo: Enviar mensaje desde Open WebUI a n8n

source n8n-integration.env

MESSAGE="$1"
MODEL="${2:-llama3}"

# Llamar a Open WebUI API
RESPONSE=$(curl -s -X POST "${OPEN_WEBUI_URL}/api/v1/chat" \
  -H "Authorization: Bearer ${OPEN_WEBUI_API_KEY}" \
  -H "Content-Type: application/json" \
  -d "{
    \"model\": \"${MODEL}\",
    \"messages\": [
      {\"role\": \"user\", \"content\": \"${MESSAGE}\"}
    ]
  }")

# Enviar respuesta a n8n
curl -X POST "${N8N_WEBHOOK_URL}" \
  -H "Content-Type: application/json" \
  -d "{
    \"message\": \"${MESSAGE}\",
    \"response\": ${RESPONSE}
  }"

echo "✅ Mensaje procesado y enviado a n8n"
EXAMPLE

chmod +x send-to-n8n-example.sh

echo "📝 Ejemplo de uso creado: send-to-n8n-example.sh"
echo "   Uso: ./send-to-n8n-example.sh 'Tu mensaje aquí' llama3"

