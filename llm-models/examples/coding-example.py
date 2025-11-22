#!/usr/bin/env python3
"""
Ejemplo: Usar DeepSeek Coder para generar código Python
"""

import requests
import json

def generate_code(prompt: str, model: str = "deepseek-coder:6.7b") -> str:
    """Genera código usando Ollama API"""
    
    response = requests.post(
        'http://localhost:11434/api/generate',
        json={
            'model': model,
            'prompt': f"Escribe código Python para: {prompt}",
            'stream': False
        }
    )
    
    return response.json()['response']

if __name__ == "__main__":
    # Ejemplo: Generar función de Fibonacci
    code = generate_code("una función que calcule la secuencia de Fibonacci")
    print("Código generado:")
    print(code)

