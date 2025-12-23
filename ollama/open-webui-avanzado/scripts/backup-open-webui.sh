#!/bin/bash
# Script de backup para Open WebUI
# Uso: ./backup-open-webui.sh

set -e

BACKUP_DIR="/backups/open-webui"
DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_NAME="open-webui-backup-${DATE}.tar.gz"

# Crear directorio de backups si no existe
mkdir -p "${BACKUP_DIR}"

# Volumen de datos de Open WebUI
DATA_VOLUME="open-webui-data"

echo "🔄 Creando backup de Open WebUI..."

# Crear backup del volumen
docker run --rm \
  -v "${DATA_VOLUME}:/data" \
  -v "${BACKUP_DIR}:/backup" \
  alpine tar czf "/backup/${BACKUP_NAME}" -C /data .

echo "✅ Backup creado: ${BACKUP_DIR}/${BACKUP_NAME}"

# Mantener solo los últimos 7 backups
cd "${BACKUP_DIR}"
ls -t open-webui-backup-*.tar.gz | tail -n +8 | xargs -r rm

echo "🧹 Backups antiguos eliminados (manteniendo últimos 7)"

# Mostrar tamaño del backup
du -h "${BACKUP_DIR}/${BACKUP_NAME}"

