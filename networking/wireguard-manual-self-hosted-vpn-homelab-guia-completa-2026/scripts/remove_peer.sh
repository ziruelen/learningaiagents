#!/bin/bash
# Script para eliminar un peer de WireGuard

set -e

PEER_NAME=$1

if [ -z "$PEER_NAME" ]; then
    echo "Uso: $0 <nombre_peer>"
    echo "Ejemplo: $0 laptop"
    exit 1
fi

# Obtener clave pública del peer
PUBLIC_KEY_FILE="keys/${PEER_NAME}_public.key"

if [ ! -f "$PUBLIC_KEY_FILE" ]; then
    echo "❌ Error: No se encontró clave pública para $PEER_NAME"
    echo "   Buscado en: $PUBLIC_KEY_FILE"
    exit 1
fi

PUBLIC_KEY=$(cat "$PUBLIC_KEY_FILE")

# Eliminar peer del servidor
echo "Eliminando peer del servidor..."
sudo wg set wg0 peer "$PUBLIC_KEY" remove

# Guardar configuración
sudo wg-quick save wg0

# Eliminar archivos del peer
rm -f "keys/${PEER_NAME}_private.key" "$PUBLIC_KEY_FILE"
rm -f "configs/${PEER_NAME}.conf"

echo "✅ Peer eliminado: $PEER_NAME"

