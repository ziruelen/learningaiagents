#!/bin/bash
# Crea video UGC desde imágenes generadas

INPUT_DIR="${1:-./comfyui_output}"
OUTPUT_FILE="${2:-./video_output/video_ugc.mp4}"
FPS="${3:-1}"  # Frames por segundo (1 = slideshow lento)
DURATION="${4:-3}"  # Duración por imagen en segundos

# Crear directorio de salida si no existe
mkdir -p "$(dirname "$OUTPUT_FILE")"

# Crear video desde imágenes
ffmpeg -framerate $FPS \
  -pattern_type glob \
  -i "${INPUT_DIR}/ugc_video_*.png" \
  -vf "scale=1920:1080:force_original_aspect_ratio=decrease,pad=1920:1080:(ow-iw)/2:(oh-ih)/2" \
  -c:v libx264 \
  -pix_fmt yuv420p \
  -r 30 \
  "$OUTPUT_FILE" 2>&1

if [ $? -eq 0 ]; then
    echo "✅ Video creado: $OUTPUT_FILE"
else
    echo "❌ Error creando video"
    exit 1
fi

