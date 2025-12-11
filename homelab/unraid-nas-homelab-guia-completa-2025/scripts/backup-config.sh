#!/bin/bash
# Script de backup de configuración de Unraid
# Guarda flash drive, appdata y VMs

BACKUP_DEST="/mnt/disks/backup"
DATE=$(date +%Y%m%d_%H%M%S)

echo "🔄 Iniciando backup de Unraid - $(date)"

# Backup del flash drive (configuración)
if [ -d "/boot/config" ]; then
    echo "📦 Backup de configuración..."
    mkdir -p "$BACKUP_DEST/config"
    rsync -av --delete /boot/config/ "$BACKUP_DEST/config/" || echo "⚠️ Error en backup de config"
fi

# Backup de appdata (Docker)
if [ -d "/mnt/user/appdata" ]; then
    echo "📦 Backup de appdata..."
    mkdir -p "$BACKUP_DEST/appdata"
    rsync -av --delete /mnt/user/appdata/ "$BACKUP_DEST/appdata/" || echo "⚠️ Error en backup de appdata"
fi

# Backup de VMs
if [ -d "/mnt/user/domains" ]; then
    echo "📦 Backup de VMs..."
    mkdir -p "$BACKUP_DEST/domains"
    rsync -av --delete /mnt/user/domains/ "$BACKUP_DEST/domains/" || echo "⚠️ Error en backup de VMs"
fi

echo "✅ Backup completado: $BACKUP_DEST"
echo "📅 Fecha: $DATE"
