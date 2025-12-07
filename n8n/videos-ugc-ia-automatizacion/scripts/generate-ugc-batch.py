#!/usr/bin/env python3
"""
Genera batch de videos UGC desde prompts
"""

import requests
import time
import subprocess
from pathlib import Path
import json
import sys

class UGCVideoGenerator:
    def __init__(self, comfyui_url="http://localhost:8188", output_dir="./video_output"):
        self.comfyui_url = comfyui_url
        self.output_dir = Path(output_dir)
        self.output_dir.mkdir(exist_ok=True)
        self.images_dir = Path("./comfyui_output")
    
    def generate_images(self, prompt, num_images=4):
        """Genera múltiples imágenes para un video"""
        # Workflow básico de ComfyUI
        workflow = {
            "1": {
                "inputs": {"text": prompt, "clip": ["4", 0]},
                "class_type": "CLIPTextEncode"
            },
            "2": {
                "inputs": {"text": "blurry, low quality, distorted", "clip": ["4", 0]},
                "class_type": "CLIPTextEncode"
            },
            "3": {
                "inputs": {"ckpt_name": "realistic_vision_v5.safetensors"},
                "class_type": "CheckpointLoaderSimple"
            },
            "4": {
                "inputs": {"width": 512, "height": 512, "batch_size": num_images},
                "class_type": "EmptyLatentImage"
            },
            "5": {
                "inputs": {
                    "seed": int(time.time()),
                    "steps": 20,
                    "cfg": 7.0,
                    "sampler_name": "euler",
                    "scheduler": "normal",
                    "denoise": 1.0,
                    "model": ["3", 0],
                    "positive": ["1", 0],
                    "negative": ["2", 0],
                    "latent_image": ["4", 0]
                },
                "class_type": "KSampler"
            },
            "6": {
                "inputs": {"samples": ["5", 0], "vae": ["3", 2]},
                "class_type": "VAEDecode"
            },
            "7": {
                "inputs": {"filename_prefix": "ugc_video", "images": ["6", 0]},
                "class_type": "SaveImage"
            }
        }
        
        # Enviar a ComfyUI
        response = requests.post(
            f"{self.comfyui_url}/prompt",
            json={"prompt": workflow}
        )
        result = response.json()
        prompt_id = result["prompt_id"]
        
        # Esperar a que termine
        print(f"⏳ Esperando generación (Prompt ID: {prompt_id})...")
        while True:
            queue = requests.get(f"{self.comfyui_url}/queue").json()
            if not any(item[1] == prompt_id for item in queue.get("queue_running", [])):
                break
            time.sleep(1)
        
        # Obtener imágenes
        images = []
        if self.images_dir.exists():
            for img_file in sorted(self.images_dir.glob("ugc_video_*.png"), key=lambda p: p.stat().st_mtime, reverse=True)[:num_images]:
                images.append(img_file)
        
        return images
    
    def create_video(self, images, output_file, fps=1, duration=3):
        """Crea video desde imágenes usando FFmpeg"""
        if not images:
            raise ValueError("No hay imágenes para crear video")
        
        # Crear lista de archivos para FFmpeg
        file_list = self.output_dir / "file_list.txt"
        with open(file_list, 'w') as f:
            for img in images:
                f.write(f"file '{img.absolute()}'\n")
                f.write(f"duration {duration}\n")
        
        # Ejecutar FFmpeg
        cmd = [
            "ffmpeg",
            "-f", "concat",
            "-safe", "0",
            "-i", str(file_list),
            "-vf", "scale=1920:1080:force_original_aspect_ratio=decrease,pad=1920:1080:(ow-iw)/2:(oh-ih)/2",
            "-c:v", "libx264",
            "-pix_fmt", "yuv420p",
            "-r", "30",
            str(self.output_dir / output_file)
        ]
        
        result = subprocess.run(cmd, capture_output=True, text=True)
        if result.returncode != 0:
            raise RuntimeError(f"Error en FFmpeg: {result.stderr}")
        
        return self.output_dir / output_file
    
    def generate_ugc_video(self, prompt, output_name="ugc_video.mp4"):
        """Pipeline completo: generar imágenes → crear video"""
        print(f"🎨 Generando imágenes para: {prompt}")
        images = self.generate_images(prompt)
        
        if not images:
            raise RuntimeError("No se generaron imágenes")
        
        print(f"🎬 Creando video desde {len(images)} imágenes...")
        video = self.create_video(images, output_name)
        
        print(f"✅ Video creado: {video}")
        return video

def main():
    if len(sys.argv) < 2:
        print("Uso: python3 generate-ugc-batch.py 'prompt de la imagen'")
        print("Ejemplo: python3 generate-ugc-batch.py 'a person unboxing a smartphone, authentic UGC style'")
        sys.exit(1)
    
    prompt = sys.argv[1]
    output_name = sys.argv[2] if len(sys.argv) > 2 else "ugc_video.mp4"
    
    generator = UGCVideoGenerator()
    
    try:
        video = generator.generate_ugc_video(prompt, output_name)
        print(f"\n✅ Proceso completado: {video.absolute()}")
    except Exception as e:
        print(f"❌ Error: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()

