#!/bin/bash
# Pi-hole Docker Install Script
# Guía completa: https://www.eldiarioia.es/pi-hole-bloqueador-dns-homelab

set -e

echo "🛡️ Instalando Pi-hole con Docker..."

# Crear directorios
mkdir -p etc-pihole etc-dnsmasq.d

# Copiar docker-compose si no existe
if [ ! -f docker-compose.yml ]; then
    echo "📋 Copiando docker-compose.yml..."
    cp ../docker-compose.yml .
fi

# Generar password aleatorio si no está configurado
if grep -q "cambiame_por_password_seguro" docker-compose.yml; then
    NEW_PASS=$(openssl rand -base64 16)
    echo "🔐 Generando password seguro..."
    sed -i "s/cambiame_por_password_seguro/$NEW_PASS/g" docker-compose.yml
    echo "📝 Tu password de administración: $NEW_PASS"
    echo "   Guárdalo en un lugar seguro!"
fi

# Iniciar contenedor
echo "🚀 Iniciando Pi-hole..."
docker compose up -d

# Esperar a que esté listo
echo "⏳ Esperando a que Pi-hole esté listo..."
sleep 10

# Verificar estado
if docker exec pihole pihole status | grep -q "enabled"; then
    echo ""
    echo "✅ Pi-hole instalado correctamente!"
    echo ""
    echo "📊 Panel de administración: http://$(hostname -I | awk '{print $1}')/admin"
    echo ""
    echo "📋 Próximos pasos:"
    echo "   1. Accede al panel de administración"
    echo "   2. Configura tu router para usar esta IP como DNS"
    echo "   3. Añade listas de bloqueo adicionales si lo deseas"
else
    echo "❌ Error al iniciar Pi-hole. Revisa los logs:"
    echo "   docker logs pihole"
fi


