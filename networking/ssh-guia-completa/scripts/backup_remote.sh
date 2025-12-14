#!/bin/bash
# Script para hacer backup remoto con rsync

set -e

if [ -z "$3" ]; then
    echo "Uso: $0 usuario@servidor /ruta/local /ruta/remota"
    echo ""
    echo "Ejemplo:"
    echo "  $0 admin@servidor.ejemplo.com /home/usuario/backups /backup"
    exit 1
fi

SERVER="$1"
LOCAL_PATH="$2"
REMOTE_PATH="$3"

# Verificar que la ruta local existe
if [ ! -d "$LOCAL_PATH" ]; then
    echo "❌ Error: La ruta local $LOCAL_PATH no existe"
    exit 1
fi

echo "💾 Backup Remoto con RSYNC"
echo "=========================="
echo ""
echo "Servidor: $SERVER"
echo "Origen: $LOCAL_PATH"
echo "Destino: $REMOTE_PATH"
echo ""

# Hacer backup
echo "Sincronizando..."
rsync -avz --progress --delete \
    --exclude '*.log' \
    --exclude '*.tmp' \
    --exclude 'node_modules' \
    --exclude '.git' \
    "$LOCAL_PATH/" "$SERVER:$REMOTE_PATH/"

echo ""
echo "✅ Backup completado!"
