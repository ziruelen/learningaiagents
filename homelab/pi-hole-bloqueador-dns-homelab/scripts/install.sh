#!/bin/bash
# Pi-hole Quick Install Script
# Uso: ./install.sh [--with-unbound]

set -e

echo "🚀 Instalando Pi-hole..."

# Crear directorios
mkdir -p etc-pihole etc-dnsmasq.d

# Verificar Docker
if ! command -v docker &> /dev/null; then
    echo "❌ Docker no está instalado"
    exit 1
fi

# Instalar con o sin Unbound
if [ "$1" == "--with-unbound" ]; then
    echo "📦 Instalando Pi-hole + Unbound..."
    mkdir -p unbound
    docker compose -f docker-compose-with-unbound.yml up -d
else
    echo "📦 Instalando Pi-hole básico..."
    docker compose up -d
fi

# Esperar a que arranque
echo "⏳ Esperando a que Pi-hole arranque..."
sleep 10

# Verificar estado
docker exec pihole pihole status

echo ""
echo "✅ Pi-hole instalado correctamente!"
echo "🌐 Panel: http://localhost/admin"
echo "🔑 Password: tu_password_seguro (cambiar en docker-compose.yml)"

