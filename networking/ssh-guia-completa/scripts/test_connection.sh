#!/bin/bash
# Script para probar conexión SSH

set -e

if [ -z "$1" ]; then
    echo "Uso: $0 [alias_servidor|usuario@servidor]"
    echo ""
    echo "Ejemplo:"
    echo "  $0 servidor1"
    echo "  $0 admin@servidor.ejemplo.com"
    exit 1
fi

SERVER="$1"

echo "🔍 Probando conexión SSH"
echo "========================"
echo ""
echo "Servidor: $SERVER"
echo ""

# Probar conexión
if ssh -o ConnectTimeout=5 -o BatchMode=yes "$SERVER" exit 2>/dev/null; then
    echo "✅ Conexión exitosa!"
    echo ""
    echo "Información del servidor:"
    ssh "$SERVER" 'echo "  Hostname: $(hostname)" && echo "  Usuario: $(whoami)" && echo "  Uptime: $(uptime -p)"'
else
    echo "❌ Error de conexión"
    echo ""
    echo "Posibles causas:"
    echo "  - Servidor no accesible"
    echo "  - Credenciales incorrectas"
    echo "  - Firewall bloqueando"
    echo "  - Servicio SSH no corriendo"
    echo ""
    echo "Prueba con modo verbose:"
    echo "  ssh -v $SERVER"
    exit 1
fi
