#!/bin/bash
# ===========================================
# Restore Paperless-ngx
# ===========================================
# Autor: ElDiarioIA.es
# Uso: ./restore.sh <archivo_backup.tar.gz>

set -e

# Validar argumento
if [ -z "$1" ]; then
    echo "❌ Uso: ./restore.sh <archivo_backup.tar.gz>"
    exit 1
fi

BACKUP_FILE="$1"

if [ ! -f "$BACKUP_FILE" ]; then
    echo "❌ Archivo no encontrado: $BACKUP_FILE"
    exit 1
fi

# Colores
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${YELLOW}⚠️  ADVERTENCIA: Esto sobrescribirá todos los datos actuales.${NC}"
read -p "¿Continuar? (sí/no): " confirm
if [ "$confirm" != "sí" ] && [ "$confirm" != "si" ]; then
    echo "Cancelado."
    exit 0
fi

echo -e "${GREEN}📦 Iniciando restauración...${NC}"

# Crear directorio temporal
TEMP_DIR=$(mktemp -d)
trap "rm -rf $TEMP_DIR" EXIT

# Extraer backup
echo -e "${YELLOW}→ Extrayendo backup...${NC}"
tar -xzf "$BACKUP_FILE" -C "$TEMP_DIR"

# Detener contenedores
echo -e "${YELLOW}→ Deteniendo servicios...${NC}"
docker compose down

# Restaurar base de datos
echo -e "${YELLOW}→ Restaurando base de datos...${NC}"
docker compose up -d db
sleep 5  # Esperar que PostgreSQL arranque

DB_BACKUP=$(find "$TEMP_DIR" -name "*_db.sql" | head -1)
if [ -n "$DB_BACKUP" ]; then
    cat "$DB_BACKUP" | docker compose exec -T db psql -U paperless paperless
fi

# Restaurar media
echo -e "${YELLOW}→ Restaurando media...${NC}"
MEDIA_BACKUP=$(find "$TEMP_DIR" -name "*_media.tar.gz" | head -1)
if [ -n "$MEDIA_BACKUP" ]; then
    docker compose up -d webserver
    sleep 5
    cat "$MEDIA_BACKUP" | docker compose exec -T webserver tar -xzf - -C /
fi

# Restaurar data
echo -e "${YELLOW}→ Restaurando data...${NC}"
DATA_BACKUP=$(find "$TEMP_DIR" -name "*_data.tar.gz" | head -1)
if [ -n "$DATA_BACKUP" ]; then
    cat "$DATA_BACKUP" | docker compose exec -T webserver tar -xzf - -C /
fi

# Reiniciar todos los servicios
echo -e "${YELLOW}→ Reiniciando servicios...${NC}"
docker compose down
docker compose up -d

echo ""
echo -e "${GREEN}✅ Restauración completada!${NC}"
echo -e "   🌐 Accede a: http://localhost:8000"

