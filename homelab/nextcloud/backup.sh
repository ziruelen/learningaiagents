#!/bin/bash
# backup.sh - Script de backup automático para Nextcloud
# Uso: Ejecutar manualmente o con cron: 0 2 * * * /ruta/a/backup.sh

# Configuración
BACKUP_DIR="${BACKUP_DIR:-/backups/nextcloud}"
NEXTCLOUD_CONTAINER="${NEXTCLOUD_CONTAINER:-nextcloud-app}"
DB_CONTAINER="${DB_CONTAINER:-nextcloud-db}"
DB_USER="${DB_USER:-nextcloud}"
DB_PASSWORD="${DB_PASSWORD:-}"
DB_NAME="${DB_NAME:-nextcloud}"
RETENTION_DAYS="${RETENTION_DAYS:-30}"

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Función de logging
log() {
    echo -e "${GREEN}[$(date +'%Y-%m-%d %H:%M:%S')]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1" >&2
}

warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

# Verificar que los contenedores existan
if ! docker ps -a --format '{{.Names}}' | grep -q "^${NEXTCLOUD_CONTAINER}$"; then
    error "Contenedor ${NEXTCLOUD_CONTAINER} no encontrado"
    exit 1
fi

if ! docker ps -a --format '{{.Names}}' | grep -q "^${DB_CONTAINER}$"; then
    error "Contenedor ${DB_CONTAINER} no encontrado"
    exit 1
fi

# Crear directorio de backup si no existe
mkdir -p "$BACKUP_DIR"

# Fecha para nombres de archivo
DATE=$(date +%Y%m%d_%H%M%S)

log "Iniciando backup de Nextcloud..."

# Backup de base de datos
log "Backing up database..."
if docker exec "$DB_CONTAINER" mysqldump -u "$DB_USER" -p"$DB_PASSWORD" "$DB_NAME" | gzip > "$BACKUP_DIR/db_$DATE.sql.gz"; then
    log "✓ Backup de base de datos completado: db_$DATE.sql.gz"
else
    error "Fallo en backup de base de datos"
    exit 1
fi

# Backup de archivos
log "Backing up files..."
if docker exec "$NEXTCLOUD_CONTAINER" tar czf - -C /var/www/html data | gzip > "$BACKUP_DIR/files_$DATE.tar.gz"; then
    log "✓ Backup de archivos completado: files_$DATE.tar.gz"
else
    error "Fallo en backup de archivos"
    exit 1
fi

# Backup de configuración
log "Backing up configuration..."
if docker exec "$NEXTCLOUD_CONTAINER" tar czf - -C /var/www/html config | gzip > "$BACKUP_DIR/config_$DATE.tar.gz"; then
    log "✓ Backup de configuración completado: config_$DATE.tar.gz"
else
    warning "Fallo en backup de configuración (continuando...)"
fi

# Eliminar backups antiguos
log "Cleaning up old backups (más de ${RETENTION_DAYS} días)..."
DELETED=$(find "$BACKUP_DIR" -name "*.gz" -mtime +$RETENTION_DAYS -delete -print | wc -l)
if [ "$DELETED" -gt 0 ]; then
    log "✓ Eliminados $DELETED backups antiguos"
else
    log "✓ No hay backups antiguos para eliminar"
fi

# Mostrar tamaño de backups
TOTAL_SIZE=$(du -sh "$BACKUP_DIR" | cut -f1)
log "Backup completado: $DATE"
log "Tamaño total de backups: $TOTAL_SIZE"
log "Ubicación: $BACKUP_DIR"

