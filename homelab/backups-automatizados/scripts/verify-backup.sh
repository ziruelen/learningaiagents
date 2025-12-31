#!/bin/bash
# verify-backup.sh - Script para verificar integridad de backups

set -euo pipefail

# Configuración
BACKUP_TOOL="${BACKUP_TOOL:-kopia}"
REPO_PATH="${KOPIA_REPO_PATH:-/kopia-repo/my-repo}"
KOPIA_PASSWORD="${KOPIA_PASSWORD:-}"

# Colores
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1" >&2
}

verify_kopia() {
    log_info "Verificando backup Kopia..."
    
    export KOPIA_PASSWORD
    
    # Obtener último snapshot
    SNAPSHOT_ID=$(kopia snapshot list --all --password-env=KOPIA_PASSWORD | tail -1 | awk '{print $4}')
    
    if [ -z "${SNAPSHOT_ID}" ]; then
        log_error "No se encontraron snapshots"
        return 1
    fi
    
    log_info "Último snapshot: ${SNAPSHOT_ID}"
    
    # Crear directorio de prueba
    TEST_DIR="/tmp/backup-test-$(date +%Y%m%d-%H%M%S)"
    mkdir -p "${TEST_DIR}"
    
    # Restaurar snapshot de prueba
    log_info "Restaurando snapshot de prueba..."
    kopia snapshot restore "${SNAPSHOT_ID}" "${TEST_DIR}" --password-env=KOPIA_PASSWORD
    
    # Verificar que se restauraron archivos
    FILE_COUNT=$(find "${TEST_DIR}" -type f | wc -l)
    
    if [ "${FILE_COUNT}" -eq 0 ]; then
        log_error "No se restauraron archivos"
        rm -rf "${TEST_DIR}"
        return 1
    fi
    
    log_info "✅ Backup verificado: ${FILE_COUNT} archivos restaurados correctamente"
    
    # Limpiar
    rm -rf "${TEST_DIR}"
    
    return 0
}

verify_restic() {
    log_info "Verificando backup Restic..."
    
    REPO="${RESTIC_REPOSITORY:-s3:s3.amazonaws.com/my-bucket/restic}"
    export RESTIC_PASSWORD
    
    # Verificar integridad
    if restic -r "${REPO}" check --quiet; then
        log_info "✅ Repositorio verificado correctamente"
        return 0
    else
        log_error "❌ Error en verificación del repositorio"
        return 1
    fi
}

case "${BACKUP_TOOL}" in
    kopia)
        verify_kopia
        ;;
    restic)
        verify_restic
        ;;
    *)
        log_error "Herramienta no soportada: ${BACKUP_TOOL}"
        exit 1
        ;;
esac

