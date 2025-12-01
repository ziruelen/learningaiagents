#!/bin/bash
# Pi-hole Backup Script
# Guía completa: https://www.eldiarioia.es/pi-hole-bloqueador-dns-homelab

set -e

BACKUP_DIR="${1:-./backups}"
DATE=$(date +%Y-%m-%d_%H-%M-%S)
BACKUP_FILE="$BACKUP_DIR/pihole-backup-$DATE.tar.gz"

echo "💾 Creando backup de Pi-hole..."

# Crear directorio de backups
mkdir -p "$BACKUP_DIR"

# Exportar configuración usando Teleporter (dentro del contenedor)
echo "📦 Exportando configuración..."
docker exec pihole pihole -a -t

# Copiar el archivo de teleporter
TELEPORTER_FILE=$(docker exec pihole ls -t /etc/pihole/*.tar.gz 2>/dev/null | head -1)

if [ -n "$TELEPORTER_FILE" ]; then
    docker cp "pihole:$TELEPORTER_FILE" "$BACKUP_DIR/"
    echo "✅ Teleporter exportado"
fi

# Backup de volúmenes
echo "📁 Respaldando volúmenes..."
tar -czf "$BACKUP_FILE" \
    etc-pihole/ \
    etc-dnsmasq.d/ \
    docker-compose.yml \
    2>/dev/null || true

echo ""
echo "✅ Backup completado: $BACKUP_FILE"
echo ""
echo "📋 Para restaurar:"
echo "   1. Descomprime: tar -xzf $BACKUP_FILE"
echo "   2. Inicia: docker compose up -d"
echo "   3. Importa Teleporter desde el panel de administración"


