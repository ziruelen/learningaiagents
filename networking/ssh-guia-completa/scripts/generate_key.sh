#!/bin/bash
# Script para generar clave SSH Ed25519

set -e

echo "🔑 Generador de Clave SSH Ed25519"
echo "=================================="
echo ""

# Solicitar email o identificador
read -p "Introduce tu email o identificador: " IDENTIFIER

# Solicitar nombre de archivo (opcional)
read -p "Nombre de archivo (Enter para id_ed25519): " KEY_NAME
KEY_NAME=${KEY_NAME:-id_ed25519}

# Ruta completa
KEY_PATH="$HOME/.ssh/$KEY_NAME"

# Verificar si ya existe
if [ -f "$KEY_PATH" ]; then
    echo "⚠️  La clave $KEY_PATH ya existe."
    read -p "¿Sobrescribir? (s/N): " OVERWRITE
    if [ "$OVERWRITE" != "s" ] && [ "$OVERWRITE" != "S" ]; then
        echo "❌ Operación cancelada"
        exit 1
    fi
fi

# Generar clave
echo ""
echo "Generando clave Ed25519..."
ssh-keygen -t ed25519 -C "$IDENTIFIER" -f "$KEY_PATH"

# Ajustar permisos
chmod 600 "$KEY_PATH"
chmod 644 "$KEY_PATH.pub"

echo ""
echo "✅ Clave generada exitosamente!"
echo ""
echo "📋 Clave privada: $KEY_PATH"
echo "📋 Clave pública: $KEY_PATH.pub"
echo ""
echo "Para copiar la clave pública al servidor:"
echo "  ssh-copy-id -i $KEY_PATH.pub usuario@servidor"
echo ""
echo "Para ver la clave pública:"
echo "  cat $KEY_PATH.pub"
