"""
Ejemplo: Integración de Mem0 con CrewAI
Este ejemplo muestra cómo añadir memoria persistente a agentes CrewAI
"""

from crewai import Agent, Task, Crew
from mem0 import Memory
from langchain_ollama import ChatOllama
import os
from dotenv import load_dotenv

# Cargar variables de entorno
load_dotenv('configs/mem0.env')

# Inicializar memoria compartida
memory = Memory(
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

# LLM local con Ollama
llm = ChatOllama(
    model=os.getenv("LLM_MODEL", "llama3"),
    base_url=os.getenv("LLM_BASE_URL", "http://localhost:11434")
)

# Agente investigador con memoria
researcher = Agent(
    role='Investigador',
    goal='Investigar sobre el tema asignado y recordar información relevante',
    backstory='Eres un investigador experto en tecnología que recuerda investigaciones anteriores',
    llm=llm,
    memory=memory,  # Memoria persistente
    verbose=True
)

# Agente escritor con memoria compartida
writer = Agent(
    role='Escritor',
    goal='Escribir artículos basados en investigación previa',
    backstory='Eres un escritor técnico que recuerda artículos anteriores y estilo del usuario',
    llm=llm,
    memory=memory,  # Misma memoria compartida
    verbose=True
)

# Tareas
research_task = Task(
    description='Investiga sobre Mem0 y memoria persistente para agentes de IA',
    agent=researcher,
    expected_output='Resumen de investigación con puntos clave sobre Mem0'
)

write_task = Task(
    description='Escribe un artículo técnico basado en la investigación, usando información de artículos anteriores si está disponible',
    agent=writer,
    expected_output='Artículo completo sobre Mem0 con referencias a investigaciones previas'
)

# Crew con memoria persistente
crew = Crew(
    agents=[researcher, writer],
    tasks=[research_task, write_task],
    verbose=True
)

# Ejecutar - la memoria se persiste entre ejecuciones
if __name__ == "__main__":
    print("🚀 Ejecutando CrewAI con Mem0...")
    result = crew.kickoff()
    print("\n✅ Resultado:")
    print(result)

