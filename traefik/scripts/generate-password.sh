#!/bin/bash

# Script para generar contraseñas encriptadas para BasicAuth
# Uso: ./generate-password.sh usuario contraseña

if [ $# -lt 2 ]; then
    echo "Uso: $0 <usuario> <contraseña>"
    echo ""
    echo "Ejemplo:"
    echo "  $0 admin mi_contraseña_segura"
    exit 1
fi

USUARIO=$1
CONTRASEÑA=$2

# Verificar si htpasswd está instalado
if ! command -v htpasswd &> /dev/null; then
    echo "❌ htpasswd no está instalado."
    echo ""
    echo "Instálalo con:"
    echo "  Ubuntu/Debian: sudo apt-get install apache2-utils"
    echo "  CentOS/RHEL: sudo yum install httpd-tools"
    echo "  macOS: brew install httpd"
    exit 1
fi

# Generar hash
HASH=$(htpasswd -nb "$USUARIO" "$CONTRASEÑA" | sed -e s/\\$/\\$\\$/g)

echo "✅ Contraseña generada:"
echo ""
echo "Añade esta línea a tus labels de Traefik:"
echo ""
echo "  - \"traefik.http.middlewares.auth.basicauth.users=$HASH\""
echo ""
echo "Y luego aplica el middleware a tu router:"
echo ""
echo "  - \"traefik.http.routers.mi-servicio.middlewares=auth\""

