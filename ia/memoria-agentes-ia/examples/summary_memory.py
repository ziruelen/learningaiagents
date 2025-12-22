#!/usr/bin/env python3
"""
Ejemplo 2: Summary Memory - Memoria con resúmenes automáticos
Ideal para conversaciones largas. Genera resúmenes automáticamente.
"""

from langchain.memory import ConversationSummaryMemory
from langchain.llms import Ollama
from langchain.chains import ConversationChain

# Inicializar Ollama
llm = Ollama(model="llama3.2", base_url="http://localhost:11434")

# Crear memoria con resúmenes
memory = ConversationSummaryMemory(
    llm=llm,
    return_messages=True,
    max_token_limit=1000  # Límite de tokens para resúmenes
)

# Guardar múltiples interacciones
interactions = [
    ("Hola, soy desarrollador de Python", "Encantado, ¿en qué proyecto trabajas?"),
    ("Trabajo en automatización con n8n", "Interesante, ¿qué automatizas?"),
    ("Automatizo workflows de marketing", "¿Qué tipo de workflows?"),
    ("Envío de emails y análisis de datos", "¿Usas alguna herramienta específica?"),
    ("Sí, uso n8n y Python scripts", "Perfecto, ¿necesitas ayuda con algo?"),
]

for user_input, agent_output in interactions:
    memory.save_context(
        {"input": user_input},
        {"output": agent_output}
    )

# Crear cadena de conversación
conversation = ConversationChain(
    llm=llm,
    memory=memory,
    verbose=True
)

# Preguntar sobre información anterior
response = conversation.predict(
    input="¿Recuerdas en qué proyecto trabajo?"
)
print(f"\nRespuesta: {response}")

# Ver resumen generado
summary = memory.load_memory_variables({})
print(f"\nResumen de la conversación:")
print(summary.get("history", "No hay resumen aún"))

