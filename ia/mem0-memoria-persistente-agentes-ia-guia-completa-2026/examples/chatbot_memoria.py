"""
Ejemplo: Chatbot con Memoria Persistente usando Mem0
Este chatbot recuerda conversaciones anteriores incluso después de reiniciar
"""

from mem0 import Memory
from langchain_ollama import ChatOllama
from langchain.chains import ConversationChain
from langchain.memory import ConversationBufferMemory
import os
from dotenv import load_dotenv

# Cargar variables de entorno
load_dotenv('configs/mem0.env')

# Inicializar Mem0
mem0 = Memory(
    vector_store={
        "provider": "qdrant",
        "config": {
            "url": os.getenv("QDRANT_URL", "http://localhost:6333"),
            "collection_name": os.getenv("QDRANT_COLLECTION_NAME", "mem0_memories")
        }
    },
    embedding_model={
        "provider": "ollama",
        "config": {
            "model": os.getenv("EMBEDDING_MODEL", "nomic-embed-text"),
            "base_url": os.getenv("OLLAMA_URL", "http://localhost:11434")
        }
    }
)

# LLM local
llm = ChatOllama(
    model=os.getenv("LLM_MODEL", "llama3"),
    base_url=os.getenv("LLM_BASE_URL", "http://localhost:11434")
)

# Crear cadena de conversación con memoria
memory = ConversationBufferMemory()
chain = ConversationChain(llm=llm, memory=memory)

def save_to_mem0(user_input, agent_response):
    """Guarda la conversación en Mem0 para persistencia"""
    mem0.add(
        messages=[
            {"role": "user", "content": user_input},
            {"role": "assistant", "content": agent_response}
        ]
    )
    print("💾 Conversación guardada en Mem0")

def get_relevant_context(query):
    """Recupera contexto relevante de conversaciones anteriores"""
    memories = mem0.search(query)
    if memories:
        context = "\n".join([m["memory"] for m in memories[:3]])  # Top 3 más relevantes
        return f"Contexto previo:\n{context}\n\n"
    return ""

def chat(user_input):
    """Chatbot con memoria persistente"""
    # Recuperar contexto relevante
    context = get_relevant_context(user_input)
    
    # Añadir contexto al prompt
    enhanced_input = f"{context}Usuario: {user_input}"
    
    # Obtener respuesta
    response = chain.predict(input=enhanced_input)
    
    # Guardar en Mem0 para futuras sesiones
    save_to_mem0(user_input, response)
    
    return response

# Ejemplo de uso
if __name__ == "__main__":
    print("🤖 Chatbot con Memoria Persistente (Mem0)")
    print("Escribe 'salir' para terminar\n")
    
    while True:
        user_input = input("Tú: ")
        if user_input.lower() in ['salir', 'exit', 'quit']:
            print("👋 ¡Hasta luego!")
            break
        
        response = chat(user_input)
        print(f"Bot: {response}\n")

