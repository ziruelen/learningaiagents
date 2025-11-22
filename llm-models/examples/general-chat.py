#!/usr/bin/env python3
"""
Ejemplo: Chat general con Llama 3.1 8B
"""

import requests

def chat(message: str, model: str = "llama3.1:8b") -> str:
    """Envía mensaje al modelo y recibe respuesta"""
    
    response = requests.post(
        'http://localhost:11434/api/generate',
        json={
            'model': model,
            'prompt': message,
            'stream': False
        }
    )
    
    return response.json()['response']

if __name__ == "__main__":
    # Chat interactivo simple
    print("💬 Chat con Llama 3.1 8B (escribe 'salir' para terminar)")
    print("-" * 50)
    
    while True:
        user_input = input("\nTú: ")
        if user_input.lower() in ['salir', 'exit', 'quit']:
            break
        
        response = chat(user_input)
        print(f"\n🤖 {response}")

