#!/bin/bash
# Script para generar claves WireGuard

set -e

PEER_NAME=${1:-server}

if [ -z "$PEER_NAME" ]; then
    echo "Uso: $0 <nombre_peer>"
    echo "Ejemplo: $0 server"
    echo "Ejemplo: $0 laptop"
    exit 1
fi

# Crear directorio si no existe
mkdir -p keys

# Generar claves con permisos restrictivos
umask 077

# Generar clave privada
wg genkey | tee "keys/${PEER_NAME}_private.key" | wg pubkey > "keys/${PEER_NAME}_public.key"

# Mostrar claves
echo "✅ Claves generadas para: $PEER_NAME"
echo ""
echo "🔑 Clave privada (keys/${PEER_NAME}_private.key):"
cat "keys/${PEER_NAME}_private.key"
echo ""
echo "🔓 Clave pública (keys/${PEER_NAME}_public.key):"
cat "keys/${PEER_NAME}_public.key"
echo ""
echo "⚠️  IMPORTANTE: Guarda la clave privada de forma segura. Nunca la compartas."

