#!/bin/bash
# cf-zero-trust-bootstrap.sh
# Bootstrap rápido de Cloudflare Zero Trust con Tunnel

DOMAIN=$1
EMAIL=$2

if [ -z "$DOMAIN" ] || [ -z "$EMAIL" ]; then
    echo "Uso: $0 <dominio> <email>"
    echo "Ejemplo: $0 tudominio.com admin@tudominio.com"
    exit 1
fi

echo "🚀 Configurando Zero Trust para $DOMAIN..."

# Verificar que cloudflared está instalado
if ! command -v cloudflared &> /dev/null; then
    echo "❌ cloudflared no está instalado"
    echo "   Instala desde: https://github.com/cloudflare/cloudflared/releases"
    exit 1
fi

# 1. Crear túnel
echo "📡 Creando túnel..."
TUNNEL_NAME="${DOMAIN//./-}-tunnel"
TUNNEL_OUTPUT=$(cloudflared tunnel create $TUNNEL_NAME 2>&1)
TUNNEL_ID=$(echo "$TUNNEL_OUTPUT" | grep -oP 'Created tunnel \K[^ ]+' || echo "")

if [ -z "$TUNNEL_ID" ]; then
    echo "❌ Error creando túnel. Verifica que estés autenticado:"
    echo "   cloudflared tunnel login"
    exit 1
fi

echo "✅ Túnel creado: $TUNNEL_ID"

# 2. Configurar DNS
echo "🌐 Configurando DNS..."
cloudflared tunnel route dns $TUNNEL_ID $DOMAIN

# 3. Crear directorio de configuración
mkdir -p cloudflared-config
CREDENTIALS_FILE="cloudflared-config/${TUNNEL_ID}.json"

# 4. Crear configuración
cat > cloudflared-config/config.yml <<EOF
tunnel: $TUNNEL_ID
credentials-file: /etc/cloudflared/${TUNNEL_ID}.json

ingress:
  # Servicio público (sin Access)
  - hostname: public.$DOMAIN
    service: http://localhost:8080

  # Servicio protegido con Access
  - hostname: admin.$DOMAIN
    service: http://localhost:9090
    originRequest:
      noHappyEyeballs: true

  # Catch-all (404)
  - service: http_status:404
EOF

# Copiar credenciales si existen
if [ -f "$HOME/.cloudflared/${TUNNEL_ID}.json" ]; then
    cp "$HOME/.cloudflared/${TUNNEL_ID}.json" "$CREDENTIALS_FILE"
    echo "✅ Credenciales copiadas"
fi

echo ""
echo "✅ Zero Trust configurado"
echo "📝 Túnel ID: $TUNNEL_ID"
echo "📝 Configuración guardada en: cloudflared-config/config.yml"
echo ""
echo "📋 Próximos pasos:"
echo "   1. Edita cloudflared-config/config.yml con tus servicios"
echo "   2. Configura políticas Access en Zero Trust Dashboard"
echo "   3. Ejecuta: cloudflared tunnel run $TUNNEL_ID"
echo "   4. O usa docker-compose con cloudflared-zero-trust.yml"

