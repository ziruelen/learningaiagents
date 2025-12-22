#!/usr/bin/env python3
"""
Ejemplo 3: Entity Memory - Memoria de entidades específicas
Extrae y almacena información estructurada (nombres, fechas, preferencias).
"""

from langchain.memory import ConversationEntityMemory
from langchain.llms import Ollama
from langchain.chains import ConversationChain

# Inicializar Ollama
llm = Ollama(model="llama3.2", base_url="http://localhost:11434")

# Crear memoria de entidades
memory = ConversationEntityMemory(
    llm=llm,
    return_messages=True
)

# Guardar información con entidades
memory.save_context(
    {"input": "Mi nombre es Carlos y trabajo en TechCorp desde 2020"},
    {"output": "Encantado Carlos. ¿En qué departamento trabajas en TechCorp?"}
)

memory.save_context(
    {"input": "Trabajo en el departamento de DevOps y mi email es carlos@techcorp.com"},
    {"output": "Perfecto, Carlos. ¿En qué puedo ayudarte con DevOps?"}
)

memory.save_context(
    {"input": "Prefiero trabajar con Docker y Kubernetes"},
    {"output": "Entendido, te gusta Docker y Kubernetes. ¿Algún proyecto específico?"}
)

# Consultar entidades almacenadas
entities = memory.load_memory_variables({"input": "¿Cuál es mi nombre?"})
print("Entidades almacenadas:")
print(entities.get("entities", {}))

# Usar con cadena de conversación
conversation = ConversationChain(
    llm=llm,
    memory=memory,
    verbose=True
)

# Preguntar sobre información almacenada
response = conversation.predict(
    input="¿Dónde trabajo y desde cuándo?"
)
print(f"\nRespuesta: {response}")

