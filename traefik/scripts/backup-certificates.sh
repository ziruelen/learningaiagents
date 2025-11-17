#!/bin/bash

# Script para hacer backup de los certificados SSL
# Uso: ./backup-certificates.sh

set -e

BACKUP_DIR="backups"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="$BACKUP_DIR/acme_$TIMESTAMP.json"

echo "💾 Haciendo backup de certificados SSL..."

# Crear directorio de backups si no existe
mkdir -p "$BACKUP_DIR"

# Verificar que acme.json existe
if [ ! -f acme.json ]; then
    echo "❌ Archivo acme.json no encontrado."
    exit 1
fi

# Copiar archivo
cp acme.json "$BACKUP_FILE"
chmod 600 "$BACKUP_FILE"

echo "✅ Backup creado: $BACKUP_FILE"
echo ""
echo "📋 Para restaurar:"
echo "  cp $BACKUP_FILE acme.json"
echo "  chmod 600 acme.json"
echo "  docker-compose -f docker-compose.traefik.yml restart traefik"

