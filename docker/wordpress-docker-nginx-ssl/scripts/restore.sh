#!/bin/bash
# Script de restauración para WordPress en Docker
# Uso: ./restore.sh <archivo_backup.tar.gz>

set -e

if [ -z "$1" ]; then
    echo "❌ Error: Debes especificar el archivo de backup"
    echo "Uso: $0 <archivo_backup.tar.gz>"
    exit 1
fi

BACKUP_FILE="$1"

if [ ! -f "$BACKUP_FILE" ]; then
    echo "❌ Error: El archivo '$BACKUP_FILE' no existe"
    exit 1
fi

# Cargar variables de entorno si existe .env
if [ -f .env ]; then
    export $(cat .env | grep -v '^#' | xargs)
fi

TEMP_DIR=$(mktemp -d)
trap "rm -rf ${TEMP_DIR}" EXIT

echo "📦 Extrayendo backup..."
tar xzf "${BACKUP_FILE}" -C "${TEMP_DIR}" || {
    echo "❌ Error: No se pudo extraer el archivo de backup"
    exit 1
}

BACKUP_NAME=$(basename "${BACKUP_FILE}" .tar.gz)

# Verificar estructura del backup
if [ ! -f "${TEMP_DIR}/${BACKUP_NAME}/database.sql" ] || [ ! -f "${TEMP_DIR}/${BACKUP_NAME}/wordpress_files.tar.gz" ]; then
    echo "❌ Error: El backup no tiene la estructura esperada"
    exit 1
fi

echo "⚠️  ADVERTENCIA: Esta operación sobrescribirá los datos actuales"
read -p "¿Continuar? (s/N): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Ss]$ ]]; then
    echo "❌ Restauración cancelada"
    exit 1
fi

echo "🗄️ Restaurando base de datos..."
docker exec -i wordpress_db mysql \
    -u root \
    -p"${MYSQL_ROOT_PASSWORD}" \
    < "${TEMP_DIR}/${BACKUP_NAME}/database.sql" || {
    echo "❌ Error: No se pudo restaurar la base de datos"
    exit 1
}

echo "📁 Restaurando archivos WordPress..."
docker run --rm \
    --volumes-from wordpress \
    -v "${TEMP_DIR}/${BACKUP_NAME}":/backup \
    alpine sh -c "cd /var/www/html && rm -rf * && tar xzf /backup/wordpress_files.tar.gz" || {
    echo "❌ Error: No se pudo restaurar los archivos"
    exit 1
}

echo "🔧 Ajustando permisos..."
docker exec wordpress chown -R www-data:www-data /var/www/html
docker exec wordpress chmod -R 755 /var/www/html

echo "✅ Restauración completada exitosamente"
echo "   Reinicia los contenedores si es necesario: docker compose restart"

