#!/bin/bash
# backup.sh - Backup de Dify.AI (PostgreSQL + Knowledge Bases)

set -e

BACKUP_DIR="./backups"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_PATH="${BACKUP_DIR}/dify_backup_${TIMESTAMP}"

mkdir -p "${BACKUP_PATH}"

echo "💾 Iniciando backup de Dify.AI..."
echo "📁 Destino: ${BACKUP_PATH}"

# Backup PostgreSQL
echo "📦 Haciendo backup de PostgreSQL..."
docker exec dify-postgres-1 pg_dump -U dify dify > "${BACKUP_PATH}/postgres.sql" 2>/dev/null || \
docker exec $(docker ps -q -f "name=postgres") pg_dump -U dify dify > "${BACKUP_PATH}/postgres.sql"

if [ $? -eq 0 ]; then
    echo "✅ Backup PostgreSQL completado"
else
    echo "⚠️  Error en backup PostgreSQL (puede que el contenedor tenga otro nombre)"
fi

# Backup storage (knowledge bases, archivos)
echo "📦 Haciendo backup de storage..."
if [ -d "./storage" ]; then
    tar -czf "${BACKUP_PATH}/storage.tar.gz" ./storage
    echo "✅ Backup storage completado"
else
    echo "ℹ️  No se encontró directorio storage"
fi

# Backup configuración
echo "📦 Haciendo backup de configuración..."
if [ -f ".env" ]; then
    cp .env "${BACKUP_PATH}/.env"
    echo "✅ Backup configuración completado"
fi

# Crear archivo de información
cat > "${BACKUP_PATH}/backup_info.txt" << EOF
Backup Dify.AI
Fecha: $(date)
Versión: $(docker images langgenius/dify-api --format "{{.Tag}}" | head -1)
Contenedores:
$(docker ps --filter "name=dify" --format "{{.Names}}: {{.Image}}")
EOF

echo ""
echo "✅ Backup completado: ${BACKUP_PATH}"
echo ""
echo "📊 Contenido del backup:"
ls -lh "${BACKUP_PATH}"

