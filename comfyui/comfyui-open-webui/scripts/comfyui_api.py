import requests
import time
from pathlib import Path

class ComfyUIAPI:
    def __init__(self, base_url="http://localhost:8188"):
        self.base_url = base_url
    
    def generate_image(self, prompt, negative="", steps=20, cfg=7.0):
        workflow = {
            # ... (workflow completo como arriba)
        }
        
        # Enviar
        response = requests.post(
            f"{self.base_url}/prompt",
            json={"prompt": workflow}
        )
        result = response.json()
        prompt_id = result["prompt_id"]
        
        # Esperar
        while True:
            queue = requests.get(f"{self.base_url}/queue").json()
            if not any(item[1] == prompt_id for item in queue.get("queue_running", [])):
                break
            time.sleep(1)
        
        # Obtener imagen
        output_dir = Path("comfyui_output")
        images = sorted(output_dir.glob("*.png"), key=lambda p: p.stat().st_mtime, reverse=True)
        return images[0] if images else None

# Uso
comfy = ComfyUIAPI()
image = comfy.generate_image("a cyberpunk robot with red mohawk")
print(f"Imagen guardada: {image}")