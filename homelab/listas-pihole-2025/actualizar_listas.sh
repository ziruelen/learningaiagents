#!/bin/bash
# Script de actualización automática de listas Pi-hole
# Uso: ./actualizar_listas.sh

echo "🔄 Actualizando listas de Pi-hole..."
pihole -g

if [ $? -eq 0 ]; then
    echo "✅ Listas actualizadas correctamente"
    echo "📊 Estadísticas:"
    pihole -c -e
else
    echo "❌ Error al actualizar listas"
    exit 1
fi

