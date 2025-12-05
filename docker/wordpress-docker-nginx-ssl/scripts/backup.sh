#!/bin/bash
# Script de backup para WordPress en Docker
# Uso: ./backup.sh

set -e

BACKUP_DIR="${BACKUP_DIR:-/backups/wordpress}"
DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_NAME="wordpress_backup_${DATE}"

# Cargar variables de entorno si existe .env
if [ -f .env ]; then
    export $(cat .env | grep -v '^#' | xargs)
fi

mkdir -p "${BACKUP_DIR}/${BACKUP_NAME}"

echo "📦 Iniciando backup de WordPress..."

# Backup de base de datos
echo "🗄️ Respaldando base de datos..."
docker exec wordpress_db mysqldump \
    -u root \
    -p"${MYSQL_ROOT_PASSWORD}" \
    --all-databases \
    --single-transaction \
    --quick \
    --lock-tables=false \
    > "${BACKUP_DIR}/${BACKUP_NAME}/database.sql" 2>/dev/null || {
    echo "⚠️ Error: No se pudo hacer backup de la base de datos"
    echo "   Verifica que el contenedor 'wordpress_db' esté corriendo"
    exit 1
}

# Backup de archivos WordPress
echo "📁 Respaldando archivos WordPress..."
docker run --rm \
    --volumes-from wordpress \
    -v "${BACKUP_DIR}/${BACKUP_NAME}":/backup \
    alpine tar czf /backup/wordpress_files.tar.gz -C /var/www/html . 2>/dev/null || {
    echo "⚠️ Error: No se pudo hacer backup de archivos"
    echo "   Verifica que el contenedor 'wordpress' esté corriendo"
    exit 1
}

# Comprimir todo
echo "📦 Comprimiendo backup..."
cd "${BACKUP_DIR}"
tar czf "${BACKUP_NAME}.tar.gz" "${BACKUP_NAME}"
rm -rf "${BACKUP_NAME}"

# Eliminar backups antiguos (mantener últimos 7 días)
echo "🧹 Limpiando backups antiguos (>7 días)..."
find "${BACKUP_DIR}" -name "*.tar.gz" -mtime +7 -delete 2>/dev/null || true

BACKUP_SIZE=$(du -h "${BACKUP_DIR}/${BACKUP_NAME}.tar.gz" | cut -f1)
echo "✅ Backup completado: ${BACKUP_NAME}.tar.gz (${BACKUP_SIZE})"

