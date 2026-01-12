#!/bin/bash
# Script para añadir un nuevo peer a WireGuard

set -e

PEER_NAME=$1
PEER_IP=$2

if [ -z "$PEER_NAME" ] || [ -z "$PEER_IP" ]; then
    echo "Uso: $0 <nombre_peer> <ip_peer>"
    echo "Ejemplo: $0 laptop 10.0.0.5"
    exit 1
fi

# Generar claves para el peer
./scripts/generar_claves.sh "$PEER_NAME"

PRIVATE_KEY=$(cat "keys/${PEER_NAME}_private.key")
PUBLIC_KEY=$(cat "keys/${PEER_NAME}_public.key")

# Añadir peer al servidor (requiere sudo)
echo "Añadiendo peer al servidor..."
sudo wg set wg0 peer "$PUBLIC_KEY" allowed-ips "${PEER_IP}/32"

# Guardar configuración
sudo wg-quick save wg0

# Obtener clave pública del servidor
SERVER_PUBLIC_KEY=$(sudo wg show wg0 public-key)
SERVER_ENDPOINT="${SERVER_ENDPOINT:-tu-servidor.com:51820}"

# Generar archivo de configuración para el cliente
cat > "configs/${PEER_NAME}.conf" <<EOF
[Interface]
PrivateKey = $PRIVATE_KEY
Address = ${PEER_IP}/24
DNS = 1.1.1.1

[Peer]
PublicKey = $SERVER_PUBLIC_KEY
Endpoint = $SERVER_ENDPOINT
AllowedIPs = 0.0.0.0/0
PersistentKeepalive = 25
EOF

echo "✅ Peer añadido: $PEER_NAME"
echo "📄 Configuración guardada en: configs/${PEER_NAME}.conf"
echo "🔑 Clave pública: $PUBLIC_KEY"
echo ""
echo "📱 Para usar en cliente:"
echo "   - Linux: sudo wg-quick up configs/${PEER_NAME}.conf"
echo "   - Windows/iOS/Android: Importar archivo configs/${PEER_NAME}.conf"

