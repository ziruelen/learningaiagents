#!/usr/bin/env python3
"""
Ejemplo 4: Persistencia de Memoria con SQLite
Guarda y carga memoria entre sesiones usando SQLite.
"""

from langchain.memory import ConversationBufferMemory
from langchain.memory.chat_message_histories import SQLChatMessageHistory
from langchain.llms import Ollama
from langchain.chains import ConversationChain

# Configurar memoria persistente con SQLite
session_id = "user_123"  # ID único por usuario/sesión

history = SQLChatMessageHistory(
    connection_string="sqlite:///memory.db",
    session_id=session_id
)

memory = ConversationBufferMemory(
    chat_memory=history,
    return_messages=True,
    return_messages=True
)

# Inicializar LLM
llm = Ollama(model="llama3.2", base_url="http://localhost:11434")

# Crear cadena de conversación
conversation = ConversationChain(
    llm=llm,
    memory=memory,
    verbose=True
)

# Primera sesión: Guardar información
print("=== SESIÓN 1 ===")
conversation.predict(input="Hola, mi nombre es Ana")
conversation.predict(input="Tengo 28 años y soy diseñadora")
conversation.predict(input="Vivo en Madrid")

# La memoria se guarda automáticamente en SQLite

# Segunda sesión: Cargar memoria anterior
print("\n=== SESIÓN 2 (nueva instancia) ===")
# Crear nueva instancia (simula nueva sesión)
history2 = SQLChatMessageHistory(
    connection_string="sqlite:///memory.db",
    session_id=session_id  # Mismo session_id
)

memory2 = ConversationBufferMemory(
    chat_memory=history2,
    return_messages=True
)

conversation2 = ConversationChain(
    llm=llm,
    memory=memory2,
    verbose=True
)

# Preguntar sobre información de sesión anterior
response = conversation2.predict(
    input="¿Cuál es mi nombre y dónde vivo?"
)
print(f"\nRespuesta (con memoria de sesión anterior): {response}")

print("\n✅ Memoria persistida correctamente en SQLite")

