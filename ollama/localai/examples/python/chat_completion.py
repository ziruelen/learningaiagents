#!/usr/bin/env python3
"""
Ejemplo de uso de LocalAI con Python
Compatible con OpenAI SDK
"""
from openai import OpenAI

# Configurar cliente LocalAI (compatible con OpenAI)
client = OpenAI(
    api_key="not-needed",  # LocalAI no requiere API key
    base_url="http://localhost:8080/v1"  # URL de tu instancia LocalAI
)

# Usar exactamente igual que OpenAI
response = client.chat.completions.create(
    model="gpt-4",  # Nombre del modelo configurado en LocalAI
    messages=[
        {"role": "system", "content": "Eres un asistente útil."},
        {"role": "user", "content": "Explica qué es LocalAI en una frase."}
    ],
    temperature=0.7,
    max_tokens=150
)

# Imprimir respuesta
print("Respuesta de LocalAI:")
print(response.choices[0].message.content)

# Información adicional
print(f"\nModelo usado: {response.model}")
print(f"Tokens usados: {response.usage.total_tokens}")

