#!/bin/bash
# =============================================================================
# Vaultwarden Backup Script
# Autor: ElDiarioIA.es
# Uso: ./backup.sh [directorio_backup]
# =============================================================================

set -e

# Configuración
BACKUP_DIR="${1:-/home/$USER/backups/vaultwarden}"
DATA_DIR="$(dirname "$0")/vw-data"
CONTAINER_NAME="vaultwarden"
DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="$BACKUP_DIR/vaultwarden_backup_$DATE.tar.gz"
RETENTION_DAYS=30

# Colores
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${GREEN}🔐 Vaultwarden Backup Script${NC}"
echo "================================"

# Crear directorio de backup si no existe
mkdir -p "$BACKUP_DIR"

# Verificar que existe el directorio de datos
if [ ! -d "$DATA_DIR" ]; then
    echo -e "${RED}❌ Error: No se encontró el directorio de datos: $DATA_DIR${NC}"
    exit 1
fi

# Verificar si el contenedor está corriendo
if docker ps --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
    echo -e "${YELLOW}⏸️  Deteniendo contenedor para backup consistente...${NC}"
    docker stop "$CONTAINER_NAME"
    CONTAINER_WAS_RUNNING=true
else
    CONTAINER_WAS_RUNNING=false
fi

# Crear backup
echo -e "${GREEN}📦 Creando backup...${NC}"
tar -czvf "$BACKUP_FILE" -C "$DATA_DIR" .

# Reiniciar contenedor si estaba corriendo
if [ "$CONTAINER_WAS_RUNNING" = true ]; then
    echo -e "${GREEN}▶️  Reiniciando contenedor...${NC}"
    docker start "$CONTAINER_NAME"
fi

# Calcular tamaño del backup
BACKUP_SIZE=$(du -h "$BACKUP_FILE" | cut -f1)

# Eliminar backups antiguos
echo -e "${YELLOW}🗑️  Eliminando backups con más de $RETENTION_DAYS días...${NC}"
DELETED=$(find "$BACKUP_DIR" -name "vaultwarden_backup_*.tar.gz" -mtime +$RETENTION_DAYS -delete -print | wc -l)

echo ""
echo -e "${GREEN}✅ Backup completado exitosamente${NC}"
echo "================================"
echo "📁 Archivo: $BACKUP_FILE"
echo "📊 Tamaño: $BACKUP_SIZE"
echo "🗑️  Backups eliminados: $DELETED"
echo ""
echo "Para restaurar:"
echo "  tar -xzvf $BACKUP_FILE -C $DATA_DIR"

