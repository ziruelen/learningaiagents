#!/bin/bash
# Script de restore para GitLab
# Uso: ./restore.sh backup.tar.gz

GITLAB_CONTAINER="gitlab"
BACKUP_DIR="/var/opt/gitlab/backups"
BACKUP_FILE="$1"

if [ -z "$BACKUP_FILE" ]; then
    echo "❌ Error: Debes especificar el archivo de backup"
    echo "Uso: ./restore.sh backup.tar.gz"
    exit 1
fi

if [ ! -f "$BACKUP_FILE" ]; then
    echo "❌ Error: El archivo $BACKUP_FILE no existe"
    exit 1
fi

echo "⚠️  ADVERTENCIA: Este proceso detendrá GitLab y restaurará desde el backup"
read -p "¿Estás seguro? (yes/no): " CONFIRM

if [ "$CONFIRM" != "yes" ]; then
    echo "❌ Restore cancelado"
    exit 1
fi

echo "🔄 Deteniendo GitLab..."
docker stop "$GITLAB_CONTAINER"

echo "🔄 Extrayendo backup..."
BACKUP_NAME=$(basename "$BACKUP_FILE" .tar.gz)
mkdir -p /tmp/gitlab_restore
tar -xzf "$BACKUP_FILE" -C /tmp/gitlab_restore

# Copiar backup al contenedor
docker cp "/tmp/gitlab_restore/$BACKUP_NAME" "$GITLAB_CONTAINER:$BACKUP_DIR/"

echo "🔄 Iniciando restore..."
docker exec -it "$GITLAB_CONTAINER" gitlab-backup restore BACKUP="$BACKUP_NAME"

echo "🔄 Reiniciando GitLab..."
docker start "$GITLAB_CONTAINER"

echo "🧹 Limpiando archivos temporales..."
rm -rf /tmp/gitlab_restore

echo "✅ Restore completado"
echo "⏳ Espera 5-10 minutos para que GitLab inicie completamente"

