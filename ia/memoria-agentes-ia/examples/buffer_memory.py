#!/usr/bin/env python3
"""
Ejemplo 1: Buffer Memory - Memoria básica con LangChain
Almacena todas las interacciones en orden cronológico.
"""

from langchain.memory import ConversationBufferMemory
from langchain.llms import Ollama

# Inicializar memoria
memory = ConversationBufferMemory(return_messages=True)

# Guardar interacciones
memory.save_context(
    {"input": "Hola, mi nombre es María"},
    {"output": "¡Hola María! Encantado de conocerte. ¿En qué puedo ayudarte?"}
)

memory.save_context(
    {"input": "Tengo 30 años"},
    {"output": "Entendido, María. Tienes 30 años. ¿Hay algo más que quieras contarme?"}
)

memory.save_context(
    {"input": "¿Cuál es mi nombre?"},
    {"output": "Tu nombre es María."}
)

# Recuperar historial completo
history = memory.load_memory_variables({})
print("Historial completo:")
print(history["history"])

# Ejemplo con Ollama
llm = Ollama(model="llama3.2", base_url="http://localhost:11434")

# Usar memoria con LLM
from langchain.chains import ConversationChain

conversation = ConversationChain(
    llm=llm,
    memory=memory,
    verbose=True
)

response = conversation.predict(input="¿Cuántos años tengo?")
print(f"\nRespuesta del agente: {response}")

