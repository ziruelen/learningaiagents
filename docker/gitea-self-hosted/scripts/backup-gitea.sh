#!/bin/bash

# Script de backup para Gitea
# Uso: ./backup-gitea.sh

set -e

# Configuración
BACKUP_DIR="${BACKUP_DIR:-/backups/gitea}"
GITEA_DATA="${GITEA_DATA:-/data/gitea}"
RETENTION_DAYS="${RETENTION_DAYS:-30}"

# Crear directorio de backup
mkdir -p "$BACKUP_DIR"

TIMESTAMP=$(date +%Y%m%d-%H%M%S)
BACKUP_DB="${BACKUP_DIR}/gitea-db-${TIMESTAMP}.sql"
BACKUP_DATA="${BACKUP_DIR}/gitea-data-${TIMESTAMP}.tar.gz"

echo "🔄 Iniciando backup de Gitea..."

# Backup de base de datos PostgreSQL
if docker ps | grep -q gitea-postgres; then
    echo "📦 Haciendo backup de base de datos PostgreSQL..."
    docker exec gitea-postgres pg_dump -U gitea gitea > "$BACKUP_DB"
    echo "✅ Base de datos guardada: $(basename $BACKUP_DB)"
elif docker ps | grep -q gitea-mysql; then
    echo "📦 Haciendo backup de base de datos MySQL..."
    docker exec gitea-mysql mysqldump -u gitea -p${MYSQL_PASSWORD:-gitea_password} gitea > "$BACKUP_DB"
    echo "✅ Base de datos guardada: $(basename $BACKUP_DB)"
else
    echo "⚠️ No se encontró contenedor de base de datos. Saltando backup de BD."
fi

# Backup de repositorios y configuración
if [ -d "$GITEA_DATA" ]; then
    echo "📦 Haciendo backup de datos de Gitea..."
    tar -czf "$BACKUP_DATA" \
        -C "$(dirname $GITEA_DATA)" \
        "$(basename $GITEA_DATA)/git" \
        "$(basename $GITEA_DATA)/repositories" \
        "$(basename $GITEA_DATA)/conf" 2>/dev/null || {
        echo "⚠️ Advertencia: Algunos archivos no se pudieron respaldar"
        tar -czf "$BACKUP_DATA" -C "$(dirname $GITEA_DATA)" "$(basename $GITEA_DATA)" 2>/dev/null || true
    }
    echo "✅ Datos guardados: $(basename $BACKUP_DATA)"
else
    echo "⚠️ Directorio de datos no encontrado: $GITEA_DATA"
fi

# Limpiar backups antiguos
if [ -n "$RETENTION_DAYS" ] && [ "$RETENTION_DAYS" -gt 0 ]; then
    echo "🧹 Limpiando backups antiguos (más de ${RETENTION_DAYS} días)..."
    find "$BACKUP_DIR" -type f -name "gitea-*" -mtime +$RETENTION_DAYS -delete
    echo "✅ Limpieza completada"
fi

echo ""
echo "✅ Backup completado: $(date)"
echo "📁 Ubicación: $BACKUP_DIR"
echo "   - Base de datos: $(basename $BACKUP_DB)"
echo "   - Datos: $(basename $BACKUP_DATA)"

