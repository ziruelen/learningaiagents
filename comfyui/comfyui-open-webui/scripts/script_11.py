import requests
import time
import base64
from pathlib import Path

def generate_image_with_comfyui(prompt: str) -> str:
    """
    Genera una imagen usando ComfyUI basado en el prompt del usuario.
    
    Args:
        prompt: Descripción de la imagen a generar
    
    Returns:
        URL o base64 de la imagen generada
    """
    # Workflow básico (simplificado)
    workflow = {
        "1": {
            "inputs": {"text": prompt, "clip": ["4", 0]},
            "class_type": "CLIPTextEncode"
        },
        "2": {
            "inputs": {"text": "blurry, low quality", "clip": ["4", 0]},
            "class_type": "CLIPTextEncode"
        },
        "3": {
            "inputs": {"ckpt_name": "realistic_vision_v5.safetensors"},
            "class_type": "CheckpointLoaderSimple"
        },
        "4": {
            "inputs": {"width": 512, "height": 512, "batch_size": 1},
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
            "inputs": {"filename_prefix": "ComfyUI", "images": ["6", 0]},
            "class_type": "SaveImage"
        }
    }
    
    # Enviar a ComfyUI
    response = requests.post(
        "http://comfyui:8188/prompt",
        json={"prompt": workflow}
    )
    result = response.json()
    prompt_id = result["prompt_id"]
    
    # Esperar a que termine
    while True:
        queue = requests.get("http://comfyui:8188/queue").json()
        if not any(item[1] == prompt_id for item in queue.get("queue_running", [])):
            break
        time.sleep(1)
    
    # Obtener imagen (buscar archivo más reciente)
    output_dir = Path("/comfyui/output")
    images = sorted(output_dir.glob("*.png"), key=lambda p: p.stat().st_mtime, reverse=True)
    if images:
        image_data = images[0].read_bytes()
        image_b64 = base64.b64encode(image_data).decode('utf-8')
        return f"data:image/png;base64,{image_b64}"
    
    return "Error: No se pudo generar la imagen"