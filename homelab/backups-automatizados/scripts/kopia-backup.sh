#!/bin/bash
# kopia-backup.sh - Script de backup automatizado con Kopia

set -euo pipefail

# Configuración
REPO_PATH="${KOPIA_REPO_PATH:-/kopia-repo/my-repo}"
BACKUP_SOURCE="${BACKUP_SOURCE:-/data}"
KOPIA_PASSWORD="${KOPIA_PASSWORD}"

export KOPIA_PASSWORD

# Colores para output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

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

# Conectar al repositorio
log_info "Conectando al repositorio: ${REPO_PATH}"
if ! kopia repository connect filesystem --path="${REPO_PATH}" --password-env=KOPIA_PASSWORD 2>/dev/null; then
    log_info "Repositorio no existe, creando nuevo repositorio..."
    kopia repository create filesystem --path="${REPO_PATH}" --password-env=KOPIA_PASSWORD
fi

# Crear snapshot
log_info "Creando snapshot de: ${BACKUP_SOURCE}"
SNAPSHOT_ID=$(kopia snapshot create "${BACKUP_SOURCE}" \
    --tags=automated,daily \
    --description="Daily backup $(date +%Y-%m-%d)" \
    --password-env=KOPIA_PASSWORD | grep -oP 'Created snapshot \K[a-z0-9]+')

if [ -z "${SNAPSHOT_ID}" ]; then
    log_error "Error al crear snapshot"
    exit 1
fi

log_info "Snapshot creado: ${SNAPSHOT_ID}"

# Ejecutar mantenimiento (limpieza)
log_info "Ejecutando mantenimiento del repositorio..."
kopia maintenance run --full --password-env=KOPIA_PASSWORD || log_warn "Mantenimiento completado con advertencias"

# Mostrar estadísticas
log_info "Estadísticas del repositorio:"
kopia repository status --password-env=KOPIA_PASSWORD

log_info "Backup completado exitosamente"
exit 0

