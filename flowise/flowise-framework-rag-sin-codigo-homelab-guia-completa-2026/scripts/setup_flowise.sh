#!/bin/bash
# setup_flowise.sh - Script de instalación de Flowise

set -e

echo "🚀 Instalando Flowise..."

# Crear directorio de datos
mkdir -p /opt/flowise/data
chmod 755 /opt/flowise/data

# Copiar docker-compose.yml
if [ ! -f /opt/flowise/docker-compose.yml ]; then
    cp docker-compose.yml /opt/flowise/
    echo "✅ docker-compose.yml copiado"
fi

# Crear .env si no existe
if [ ! -f /opt/flowise/.env ]; then
    cat > /opt/flowise/.env <<'EOF'
FLOWISE_PASSWORD=changeme
POSTGRES_PASSWORD=changeme
EOF
    echo "✅ .env creado (cambiar passwords!)"
fi

# Iniciar Flowise
cd /opt/flowise
docker-compose up -d

echo ""
echo "✅ Flowise instalado en http://localhost:3000"
echo "📝 Usuario: admin"
echo "🔑 Password: changeme (cambiar en .env)"
echo ""
echo "Para producción, usar: docker-compose -f docker-compose.production.yml up -d"

