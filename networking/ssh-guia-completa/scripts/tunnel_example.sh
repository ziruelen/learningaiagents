#!/bin/bash
# Script de ejemplo para crear túnel SSH

set -e

if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Uso: $0 usuario@servidor puerto_local [puerto_remoto] [host_remoto]"
    echo ""
    echo "Ejemplos:"
    echo "  # Túnel local para PostgreSQL"
    echo "  $0 admin@servidor.ejemplo.com 5432 5432 localhost"
    echo ""
    echo "  # Túnel local para web interna"
    echo "  $0 admin@servidor.ejemplo.com 8080 8080 localhost"
    echo ""
    echo "  # Túnel remoto (exponer servicio local)"
    echo "  $0 admin@servidor.ejemplo.com 3000 8080 localhost -R"
    exit 1
fi

SERVER="$1"
LOCAL_PORT="$2"
REMOTE_PORT="${3:-$LOCAL_PORT}"
REMOTE_HOST="${4:-localhost}"
TUNNEL_TYPE="${5:--L}"

if [ "$TUNNEL_TYPE" = "-R" ]; then
    echo "🌐 Creando túnel remoto (Remote Port Forwarding)"
    echo "================================================"
    echo ""
    echo "Servidor: $SERVER"
    echo "Puerto remoto: $REMOTE_PORT -> Puerto local: $LOCAL_PORT"
    echo ""
    echo "El servicio local en puerto $LOCAL_PORT será accesible"
    echo "en el servidor remoto en puerto $REMOTE_PORT"
    echo ""
    ssh -R "$REMOTE_PORT:$REMOTE_HOST:$LOCAL_PORT" "$SERVER"
else
    echo "🌐 Creando túnel local (Local Port Forwarding)"
    echo "=============================================="
    echo ""
    echo "Servidor: $SERVER"
    echo "Puerto local: $LOCAL_PORT -> Puerto remoto: $REMOTE_PORT"
    echo ""
    echo "El servicio remoto estará accesible en localhost:$LOCAL_PORT"
    echo ""
    echo "Presiona Ctrl+C para cerrar el túnel"
    echo ""
    ssh -L "$LOCAL_PORT:$REMOTE_HOST:$REMOTE_PORT" "$SERVER"
fi
