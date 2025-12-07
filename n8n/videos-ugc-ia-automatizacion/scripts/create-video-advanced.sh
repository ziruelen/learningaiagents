#!/bin/bash
# Crea video UGC con transiciones y efectos avanzados

INPUT_DIR="${1:-./comfyui_output}"
OUTPUT_FILE="${2:-./video_output/video_ugc_advanced.mp4}"
AUDIO_FILE="${3:-}"  # Opcional: archivo de audio de fondo

# Crear directorio de salida si no existe
mkdir -p "$(dirname "$OUTPUT_FILE")"

# Crear video con transiciones suaves
ffmpeg -framerate 0.5 \
  -pattern_type glob \
  -i "${INPUT_DIR}/ugc_video_*.png" \
  -vf "scale=1920:1080:force_original_aspect_ratio=decrease,pad=1920:1080:(ow-iw)/2:(oh-ih)/2,fps=30,scale=1920:1080" \
  -c:v libx264 \
  -preset slow \
  -crf 18 \
  -pix_fmt yuv420p \
  -r 30 \
  "$OUTPUT_FILE" 2>&1

if [ $? -ne 0 ]; then
    echo "❌ Error creando video"
    exit 1
fi

# Añadir audio si existe
if [ -n "$AUDIO_FILE" ] && [ -f "$AUDIO_FILE" ]; then
    OUTPUT_WITH_AUDIO="${OUTPUT_FILE%.mp4}_with_audio.mp4"
    ffmpeg -i "$OUTPUT_FILE" -i "$AUDIO_FILE" \
      -c:v copy \
      -c:a aac \
      -shortest \
      "$OUTPUT_WITH_AUDIO" 2>&1
    
    if [ $? -eq 0 ]; then
        echo "✅ Video con audio creado: $OUTPUT_WITH_AUDIO"
    fi
fi

echo "✅ Video creado: $OUTPUT_FILE"

