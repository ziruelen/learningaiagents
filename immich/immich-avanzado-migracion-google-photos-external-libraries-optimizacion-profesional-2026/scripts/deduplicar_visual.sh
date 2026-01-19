#!/bin/bash
# deduplicar_visual.sh
# Script para deduplicación visual usando immich-deduper

set -e

IMMICH_URL="${1:-https://immich.tu-dominio.com}"
IMMICH_API_KEY="${2:-tu-api-key}"
LIBRARY_ID="${3:-}"
SIMILARITY_THRESHOLD="${4:-0.95}"
DRY_RUN="${5:-true}"

if [ -z "$LIBRARY_ID" ]; then
    echo "Uso: $0 <immich_url> <api_key> <library_id> [similarity_threshold] [dry_run]"
    echo ""
    echo "Ejemplo:"
    echo "  $0 https://immich.example.com abc123 library-123 0.95 true"
    echo ""
    echo "Para obtener library_id:"
    echo "  curl -H \"X-API-KEY: \$API_KEY\" \$IMMICH_URL/api/library | jq '.[] | {id, name}'"
    exit 1
fi

echo "🔍 Deduplicación visual con Immich-Deduper"
echo "   URL: $IMMICH_URL"
echo "   Library ID: $LIBRARY_ID"
echo "   Similarity: $SIMILARITY_THRESHOLD"
echo "   Dry run: $DRY_RUN"
echo ""

# Verificar si immich-deduper está instalado
if ! command -v immich-deduper &> /dev/null; then
    echo "📦 Instalando immich-deduper..."
    pip3 install immich-deduper
fi

# Ejecutar deduplicación
OUTPUT_FILE="duplicates_$(date +%Y%m%d_%H%M%S).json"

if [ "$DRY_RUN" = "true" ]; then
    echo "🔍 Ejecutando en modo DRY-RUN (no eliminará duplicados)..."
    immich-deduper \
        --immich-url "$IMMICH_URL" \
        --api-key "$IMMICH_API_KEY" \
        --library-id "$LIBRARY_ID" \
        --similarity-threshold "$SIMILARITY_THRESHOLD" \
        --dry-run \
        --output "$OUTPUT_FILE"
else
    echo "⚠️  MODO REAL: Se eliminarán duplicados!"
    read -p "¿Continuar? (s/N): " confirm
    if [ "$confirm" != "s" ]; then
        echo "❌ Cancelado"
        exit 1
    fi
    
    immich-deduper \
        --immich-url "$IMMICH_URL" \
        --api-key "$IMMICH_API_KEY" \
        --library-id "$LIBRARY_ID" \
        --similarity-threshold "$SIMILARITY_THRESHOLD" \
        --delete-duplicates \
        --output "$OUTPUT_FILE"
fi

# Mostrar resultados
echo ""
echo "📊 Resultados guardados en: $OUTPUT_FILE"
echo ""
echo "Duplicados encontrados:"
jq 'length' "$OUTPUT_FILE"

echo ""
echo "Duplicados con alta similitud (>0.98):"
jq '[.[] | select(.similarity > 0.98)] | length' "$OUTPUT_FILE"

echo ""
echo "💡 Para revisar duplicados manualmente:"
echo "   cat $OUTPUT_FILE | jq '.[] | select(.similarity > 0.98)'"

