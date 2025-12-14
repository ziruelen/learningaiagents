#!/bin/bash
# Script para copiar clave SSH al servidor

set -e

if [ -z "$1" ]; then
    echo "Uso: $0 usuario@servidor [ruta_clave_publica]"
    echo ""
    echo "Ejemplo:"
    echo "  $0 admin@servidor.ejemplo.com"
    echo "  $0 admin@servidor.ejemplo.com ~/.ssh/id_ed25519.pub"
    exit 1
fi

SERVER="$1"
PUB_KEY="${2:-$HOME/.ssh/id_ed25519.pub}"

# Verificar que existe la clave pública
if [ ! -f "$PUB_KEY" ]; then
    echo "❌ Error: No se encontró la clave pública en $PUB_KEY"
    exit 1
fi

echo "🔑 Copiando clave SSH al servidor"
echo "=================================="
echo ""
echo "Servidor: $SERVER"
echo "Clave: $PUB_KEY"
echo ""

# Intentar usar ssh-copy-id primero
if command -v ssh-copy-id &> /dev/null; then
    echo "Usando ssh-copy-id..."
    ssh-copy-id -i "$PUB_KEY" "$SERVER"
else
    echo "ssh-copy-id no disponible, usando método manual..."
    cat "$PUB_KEY" | ssh "$SERVER" "mkdir -p ~/.ssh && chmod 700 ~/.ssh && cat >> ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys"
fi

echo ""
echo "✅ Clave copiada exitosamente!"
echo ""
echo "Prueba la conexión:"
echo "  ssh $SERVER"
