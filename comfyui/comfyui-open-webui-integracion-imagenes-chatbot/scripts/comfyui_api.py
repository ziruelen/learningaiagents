#!/usr/bin/env python3
"""
ComfyUI API Client: Cliente Python para generar imágenes con ComfyUI
Uso: python3 comfyui_api.py "a cyberpunk robot with red mohawk"
"""

import requests
import json
import time
import sys
from pathlib import Path


class ComfyUIAPI:
    def __init__(self, base_url="http://localhost:8188"):
        self.base_url = base_url
    
    def queue_prompt(self, workflow_json):
        """Envía un workflow a la cola de ComfyUI"""
        response = requests.post(
            f"{self.base_url}/prompt",
            json={"prompt": workflow_json}
        )
        response.raise_for_status()
        return response.json()
    
    def get_image(self, filename, subfolder="output", type="output"):
        """Obtiene una imagen generada"""
        response = requests.get(
            f"{self.base_url}/view",
            params={
                "filename": filename,
                "subfolder": subfolder,
                "type": type
            }
        )
        response.raise_for_status()
        return response.content
    
    def get_queue_status(self):
        """Obtiene el estado de la cola"""
        response = requests.get(f"{self.base_url}/queue")
        response.raise_for_status()
        return response.json()
    
    def wait_for_completion(self, prompt_id, timeout=300):
        """Espera a que un prompt termine de procesarse"""
        start_time = time.time()
        while time.time() - start_time < timeout:
            queue = self.get_queue_status()
            
            # Verificar si está en cola corriendo
            running = [item[1] for item in queue.get("queue_running", [])]
            if prompt_id not in running:
                # Verificar si terminó (está en history)
                history = queue.get("queue_history", [])
                for item in history:
                    if item[1] == prompt_id:
                        return True
                # Si no está en running ni history, puede haber fallado
                return False
            
            time.sleep(1)
        
        raise TimeoutError(f"Timeout esperando prompt {prompt_id}")
    
    def generate_image(self, prompt, negative_prompt="", steps=20, cfg=7.0, seed=-1, width=512, height=512):
        """Genera una imagen desde un prompt simple"""
        
        # Workflow básico de ComfyUI
        workflow = {
            "1": {
                "inputs": {"text": prompt, "clip": ["4", 0]},
                "class_type": "CLIPTextEncode"
            },
            "2": {
                "inputs": {"text": negative_prompt, "clip": ["4", 0]},
                "class_type": "CLIPTextEncode"
            },
            "3": {
                "inputs": {"ckpt_name": "realistic_vision_v5.safetensors"},
                "class_type": "CheckpointLoaderSimple"
            },
            "4": {
                "inputs": {"width": width, "height": height, "batch_size": 1},
                "class_type": "EmptyLatentImage"
            },
            "5": {
                "inputs": {
                    "seed": seed if seed > 0 else int(time.time()),
                    "steps": steps,
                    "cfg": cfg,
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
                "inputs": {"filename_prefix": "ComfyUI", "images": ["6", 0]},
                "class_type": "SaveImage"
            }
        }
        
        # Enviar a cola
        print(f"📤 Enviando prompt a ComfyUI: '{prompt}'")
        result = self.queue_prompt(workflow)
        prompt_id = result["prompt_id"]
        print(f"✅ Prompt ID: {prompt_id}")
        
        # Esperar a que termine
        print("⏳ Esperando generación...")
        if not self.wait_for_completion(prompt_id):
            raise RuntimeError(f"Prompt {prompt_id} falló o no se completó")
        
        # Obtener imagen (buscar el archivo más reciente)
        # Nota: En producción, usar el filename devuelto por el workflow
        output_dir = Path("comfyui_output")
        if output_dir.exists():
            images = sorted(output_dir.glob("*.png"), key=lambda p: p.stat().st_mtime, reverse=True)
            if images:
                return images[0].read_bytes()
        
        # Fallback: intentar obtener por API
        image_data = self.get_image("ComfyUI_00001_.png")
        return image_data


def main():
    if len(sys.argv) < 2:
        print("Uso: python3 comfyui_api.py 'prompt de la imagen'")
        print("Ejemplo: python3 comfyui_api.py 'a cyberpunk robot with red mohawk'")
        sys.exit(1)
    
    prompt = sys.argv[1]
    negative = sys.argv[2] if len(sys.argv) > 2 else "blurry, low quality, distorted"
    
    comfy = ComfyUIAPI()
    
    try:
        image_data = comfy.generate_image(prompt, negative)
        
        output_path = Path("output.png")
        output_path.write_bytes(image_data)
        print(f"✅ Imagen guardada: {output_path.absolute()}")
        
    except Exception as e:
        print(f"❌ Error: {e}")
        sys.exit(1)


if __name__ == "__main__":
    main()

