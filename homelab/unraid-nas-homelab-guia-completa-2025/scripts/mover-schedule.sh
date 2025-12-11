#!/bin/bash
# Script para ejecutar Mover manualmente y verificar estado
# Útil para debugging o ejecución manual

echo "🔄 Ejecutando Mover de Unraid..."
echo "📅 Fecha: $(date)"

# Ejecutar mover
/usr/local/sbin/mover

# Verificar espacio en cache
echo ""
echo "💾 Estado del cache:"
df -h /mnt/cache 2>/dev/null || echo "⚠️ Cache no montado"

# Verificar espacio en array
echo ""
echo "💾 Estado del array:"
df -h /mnt/user 2>/dev/null || echo "⚠️ Array no montado"

echo ""
echo "✅ Mover completado"
