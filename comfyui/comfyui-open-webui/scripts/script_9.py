import requests
import json
import time

def generate_image(prompt):
    # Workflow básico
    workflow = {
        "1": {
            "inputs": {"text": prompt, "clip": ["4", 0]},
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
    
    # Enviar a cola
    response = requests.post(
        "http://localhost:8188/prompt",
        json={"prompt": workflow}
    )
    return response.json()

# Probar
result = generate_image("a cyberpunk robot with red mohawk")
print(f"Prompt ID: {result['prompt_id']}")