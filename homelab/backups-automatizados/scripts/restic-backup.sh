#!/bin/bash
# restic-backup.sh - Script de backup automatizado con Restic

set -euo pipefail

# Configuración
REPO="${RESTIC_REPOSITORY:-s3:s3.amazonaws.com/my-bucket/restic}"
BACKUP_SOURCE="${BACKUP_SOURCE:-/data}"
RESTIC_PASSWORD="${RESTIC_PASSWORD}"

export RESTIC_PASSWORD

# Colores para output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

log_info() {
    echo -e "${GREEN}[INFO]${NC} $(date '+%Y-%m-%d %H:%M:%S') - $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $(date '+%Y-%m-%d %H:%M:%S') - $1" >&2
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $(date '+%Y-%m-%d %H:%M:%S') - $1"
}

# Verificar que existe el directorio de backup
if [ ! -d "${BACKUP_SOURCE}" ]; then
    log_error "Directorio de backup no existe: ${BACKUP_SOURCE}"
    exit 1
fi

# Inicializar repositorio si no existe
log_info "Inicializando repositorio: ${REPO}"
if ! restic -r "${REPO}" snapshots >/dev/null 2>&1; then
    log_info "Repositorio no existe, creando nuevo repositorio..."
    restic -r "${REPO}" init
fi

# Backup
log_info "Creando backup de: ${BACKUP_SOURCE}"
if ! restic -r "${REPO}" backup "${BACKUP_SOURCE}" \
    --tag="automated,daily" \
    --exclude="*.tmp" \
    --exclude="node_modules" \
    --exclude=".git"; then
    log_error "Error al crear backup"
    exit 1
fi

log_info "Backup completado"

# Limpiar snapshots antiguos
log_info "Limpiando snapshots antiguos..."
restic -r "${REPO}" forget \
    --keep-last 10 \
    --keep-daily 7 \
    --keep-weekly 4 \
    --keep-monthly 12 \
    --keep-yearly 5 \
    --prune

# Verificar integridad
log_info "Verificando integridad del repositorio..."
if ! restic -r "${REPO}" check --quiet; then
    log_warn "Verificación de integridad encontró problemas"
fi

# Mostrar estadísticas
log_info "Estadísticas del repositorio:"
restic -r "${REPO}" stats

log_info "Backup completado exitosamente"
exit 0

