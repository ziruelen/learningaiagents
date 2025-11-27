#!/bin/bash
# ===========================================
# Backup Paperless-ngx
# ===========================================
# Autor: ElDiarioIA.es
# Uso: ./backup.sh [directorio_destino]

set -e

# Configuración
BACKUP_DIR="${1:-./backups}"
DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_NAME="paperless_backup_${DATE}"

# Colores
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${GREEN}📦 Iniciando backup de Paperless-ngx...${NC}"

# Crear directorio de backup
mkdir -p "${BACKUP_DIR}"

# 1. Backup de base de datos
echo -e "${YELLOW}→ Exportando base de datos...${NC}"
docker compose exec -T db pg_dump -U paperless paperless > "${BACKUP_DIR}/${BACKUP_NAME}_db.sql"

# 2. Backup de media (documentos originales + thumbnails)
echo -e "${YELLOW}→ Comprimiendo media...${NC}"
docker compose exec -T webserver tar -czf - /usr/src/paperless/media > "${BACKUP_DIR}/${BACKUP_NAME}_media.tar.gz"

# 3. Backup de data (index, clasificadores)
echo -e "${YELLOW}→ Comprimiendo data...${NC}"
docker compose exec -T webserver tar -czf - /usr/src/paperless/data > "${BACKUP_DIR}/${BACKUP_NAME}_data.tar.gz"

# 4. Backup de configuración
echo -e "${YELLOW}→ Guardando configuración...${NC}"
cp .env "${BACKUP_DIR}/${BACKUP_NAME}_env.backup" 2>/dev/null || echo "No .env encontrado"
cp docker-compose.yml "${BACKUP_DIR}/${BACKUP_NAME}_compose.yml"

# 5. Crear archivo combinado
echo -e "${YELLOW}→ Creando archivo final...${NC}"
cd "${BACKUP_DIR}"
tar -czf "${BACKUP_NAME}.tar.gz" \
    "${BACKUP_NAME}_db.sql" \
    "${BACKUP_NAME}_media.tar.gz" \
    "${BACKUP_NAME}_data.tar.gz" \
    "${BACKUP_NAME}_env.backup" \
    "${BACKUP_NAME}_compose.yml" 2>/dev/null || true

# Limpiar archivos temporales
rm -f "${BACKUP_NAME}_db.sql" "${BACKUP_NAME}_media.tar.gz" \
      "${BACKUP_NAME}_data.tar.gz" "${BACKUP_NAME}_env.backup" \
      "${BACKUP_NAME}_compose.yml" 2>/dev/null || true

# Calcular tamaño
SIZE=$(du -h "${BACKUP_NAME}.tar.gz" | cut -f1)

echo ""
echo -e "${GREEN}✅ Backup completado!${NC}"
echo -e "   📁 Archivo: ${BACKUP_DIR}/${BACKUP_NAME}.tar.gz"
echo -e "   📊 Tamaño: ${SIZE}"
echo ""
echo -e "${YELLOW}💡 Para restaurar:${NC}"
echo -e "   ./scripts/restore.sh ${BACKUP_DIR}/${BACKUP_NAME}.tar.gz"

