#!/usr/bin/env python3
"""
normalizar_metadatos.py
Normaliza metadatos EXIF desde Google Takeout JSON a formato estándar
"""

import os
import json
import sys
from pathlib import Path
from datetime import datetime
from PIL import Image
from PIL.ExifTags import TAGS

def normalize_metadata(photo_path, google_json_path=None):
    """
    Normaliza metadatos EXIF desde Google Takeout JSON
    
    Args:
        photo_path: Ruta a la foto
        google_json_path: Ruta al JSON de Google Takeout (opcional)
    
    Returns:
        Dict con metadatos normalizados
    """
    img = Image.open(photo_path)
    exif = img.getexif()
    
    metadata = {}
    
    # Leer metadatos EXIF existentes
    for tag_id, value in exif.items():
        tag = TAGS.get(tag_id, tag_id)
        metadata[tag] = value
    
    # Si hay JSON de Google Takeout, usar esos metadatos
    if google_json_path and os.path.exists(google_json_path):
        with open(google_json_path, 'r', encoding='utf-8') as f:
            google_data = json.load(f)
            
            # Extraer fecha de creación
            if 'photoTakenTime' in google_data:
                timestamp = google_data['photoTakenTime']['timestamp']
                date_taken = datetime.fromtimestamp(int(timestamp))
                metadata['DateTimeOriginal'] = date_taken.strftime('%Y:%m:%d %H:%M:%S')
            
            # Extraer descripción si existe
            if 'description' in google_data:
                metadata['ImageDescription'] = google_data['description']
            
            # Extraer ubicación si existe
            if 'geoData' in google_data:
                lat = google_data['geoData'].get('latitude', 0)
                lon = google_data['geoData'].get('longitude', 0)
                if lat != 0 and lon != 0:
                    metadata['GPSLatitude'] = lat
                    metadata['GPSLongitude'] = lon
    
    return metadata


def process_directory(photo_dir, json_dir=None):
    """
    Procesa todos los archivos de un directorio
    """
    photo_dir = Path(photo_dir)
    json_dir = Path(json_dir) if json_dir else None
    
    processed = 0
    errors = 0
    
    for photo in photo_dir.rglob("*"):
        if photo.suffix.lower() in ['.jpg', '.jpeg', '.png', '.heic']:
            try:
                # Buscar JSON correspondiente
                json_path = None
                if json_dir:
                    json_file = json_dir / f"{photo.stem}.json"
                    if json_file.exists():
                        json_path = str(json_file)
                
                metadata = normalize_metadata(str(photo), json_path)
                processed += 1
                
                if processed % 100 == 0:
                    print(f"   Procesadas: {processed} fotos...")
                    
            except Exception as e:
                print(f"⚠️  Error procesando {photo}: {e}")
                errors += 1
    
    print(f"\n✅ Procesamiento completado:")
    print(f"   Procesadas: {processed}")
    print(f"   Errores: {errors}")


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Uso: python3 normalizar_metadatos.py <directorio_fotos> [directorio_json]")
        print("Ejemplo: python3 normalizar_metadatos.py /mnt/fotos /mnt/google_takeout/json")
        sys.exit(1)
    
    photo_dir = sys.argv[1]
    json_dir = sys.argv[2] if len(sys.argv) > 2 else None
    
    print(f"🔄 Normalizando metadatos en: {photo_dir}")
    if json_dir:
        print(f"📄 Usando JSONs de: {json_dir}")
    
    process_directory(photo_dir, json_dir)

