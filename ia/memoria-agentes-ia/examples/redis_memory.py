#!/usr/bin/env python3
"""
Ejemplo 5: Memoria Distribuida con Redis
Ideal para producción con múltiples instancias del agente.
"""

from langchain.memory import ConversationBufferMemory
from langchain.memory.chat_message_histories import RedisChatMessageHistory
from langchain.llms import Ollama
from langchain.chains import ConversationChain
import redis

# Conectar a Redis
redis_client = redis.Redis(
    host='localhost',
    port=6379,
    db=0,
    decode_responses=True
)

# Verificar conexión
try:
    redis_client.ping()
    print("✅ Conectado a Redis")
except Exception as e:
    print(f"❌ Error conectando a Redis: {e}")
    print("Asegúrate de que Redis esté corriendo: docker run -d -p 6379:6379 redis")
    exit(1)

# Configurar memoria con Redis
session_id = "user_456"

history = RedisChatMessageHistory(
    redis_client=redis_client,
    session_id=session_id,
    key_prefix="agent_memory:"
)

memory = ConversationBufferMemory(
    chat_memory=history,
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

# Guardar información
print("=== Guardando información en Redis ===")
conversation.predict(input="Soy Luis, desarrollador backend")
conversation.predict(input="Uso Python, FastAPI y PostgreSQL")
conversation.predict(input="Trabajo en proyectos de e-commerce")

# La memoria se guarda automáticamente en Redis

# Verificar que se guardó
print("\n=== Verificando memoria en Redis ===")
stored = redis_client.get(f"agent_memory:{session_id}")
if stored:
    print("✅ Memoria almacenada en Redis")
else:
    print("⚠️ No se encontró memoria (puede estar en formato diferente)")

# Consultar información guardada
response = conversation.predict(
    input="¿Qué tecnologías uso y en qué tipo de proyectos trabajo?"
)
print(f"\nRespuesta: {response}")

print("\n✅ Memoria distribuida funcionando con Redis")

