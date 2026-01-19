#!/bin/bash
# backup_immich_db.sh
# Script para backup automatizado de Immich (base de datos + library)

set -e

BACKUP_DIR="${1:-/mnt/backups/immich}"
DB_CONTAINER="${2:-immich-postgres}"
DB_NAME="${3:-immich}"
DB_USER="${4:-immich}"
LIBRARY_PATH="${5:-./library}"
RETENTION_DAYS="${6:-30}"

DATE=$(date +%Y%m%d_%H%M%S)
mkdir -p "$BACKUP_DIR"

echo "💾 Backup de Immich - $DATE"
echo "   Destino: $BACKUP_DIR"
echo ""

# 1. Backup de PostgreSQL
echo "📊 Haciendo backup de base de datos..."
DB_BACKUP="$BACKUP_DIR/db_$DATE.sql.gz"

if docker ps | grep -q "$DB_CONTAINER"; then
    docker exec "$DB_CONTAINER" pg_dump -U "$DB_USER" "$DB_NAME" | gzip > "$DB_BACKUP"
    echo "   ✅ Base de datos: $(du -h "$DB_BACKUP" | cut -f1)"
else
    echo "   ⚠️  Contenedor $DB_CONTAINER no está corriendo"
fi

# 2. Backup de thumbnails y uploads
echo "📁 Haciendo backup de library..."
LIBRARY_BACKUP="$BACKUP_DIR/library_$DATE.tar.gz"

if [ -d "$LIBRARY_PATH" ]; then
    tar -czf "$LIBRARY_BACKUP" "$LIBRARY_PATH" 2>/dev/null || {
        echo "   ⚠️  Error comprimiendo library (puede ser muy grande)"
        echo "   💡 Considera usar rsync o rclone para backups incrementales"
    }
    if [ -f "$LIBRARY_BACKUP" ]; then
        echo "   ✅ Library: $(du -h "$LIBRARY_BACKUP" | cut -f1)"
    fi
else
    echo "   ⚠️  Directorio $LIBRARY_PATH no existe"
fi

# 3. Sincronizar con S3/Backblaze (si rclone está configurado)
if command -v rclone &> /dev/null; then
    echo "☁️  Sincronizando con almacenamiento remoto..."
    rclone sync "$BACKUP_DIR" s3:immich-backups/ --delete-after 2>&1 | tail -5
    echo "   ✅ Sincronización completada"
fi

# 4. Limpiar backups antiguos
echo "🧹 Limpiando backups antiguos (>$RETENTION_DAYS días)..."
find "$BACKUP_DIR" -name "*.gz" -mtime +$RETENTION_DAYS -delete
find "$BACKUP_DIR" -name "*.tar.gz" -mtime +$RETENTION_DAYS -delete

echo ""
echo "✅ Backup completado: $DATE"
echo "   Ubicación: $BACKUP_DIR"

