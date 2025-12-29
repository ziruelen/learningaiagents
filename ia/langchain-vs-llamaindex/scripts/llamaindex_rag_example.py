#!/usr/bin/env python3
"""
Ejemplo LlamaIndex RAG con Qdrant y Ollama
Basado en el artículo: LangChain vs LlamaIndex - Framework RAG para Homelab
"""

from llama_index import VectorStoreIndex, ServiceContext, StorageContext
from llama_index.vector_stores import QdrantVectorStore
from llama_index.embeddings import OllamaEmbedding
from llama_index.llms import Ollama
from llama_index.readers import SimpleDirectoryReader
import os

# Configuración
QDRANT_URL = os.getenv("QDRANT_URL", "http://localhost:6333")
OLLAMA_URL = os.getenv("OLLAMA_URL", "http://localhost:11434")
OLLAMA_MODEL = os.getenv("OLLAMA_MODEL", "llama3")
EMBEDDING_MODEL = os.getenv("EMBEDDING_MODEL", "nomic-embed-text")
STORAGE_DIR = os.getenv("STORAGE_DIR", "./storage")

def setup_llamaindex_rag(documents_dir: str = "data"):
    """
    Configura pipeline RAG con LlamaIndex
    
    Args:
        documents_dir: Directorio con documentos
    """
    print("📚 Cargando documentos...")
    documents = SimpleDirectoryReader(documents_dir).load_data()
    print(f"   ✓ {len(documents)} documentos cargados")
    
    print("🤖 Configurando LLM y embeddings...")
    llm = Ollama(
        model=OLLAMA_MODEL,
        base_url=OLLAMA_URL,
        request_timeout=120.0
    )
    
    embed_model = OllamaEmbedding(
        model_name=EMBEDDING_MODEL,
        base_url=OLLAMA_URL
    )
    
    service_context = ServiceContext.from_defaults(
        llm=llm,
        embed_model=embed_model
    )
    
    print("🔗 Creando vector store en Qdrant...")
    vector_store = QdrantVectorStore(
        url=QDRANT_URL,
        collection_name="llamaindex_documents"
    )
    
    storage_context = StorageContext.from_defaults(
        vector_store=vector_store
    )
    
    print("📇 Creando índice...")
    index = VectorStoreIndex.from_documents(
        documents,
        storage_context=storage_context,
        service_context=service_context
    )
    
    # Persistir índice (opcional)
    if STORAGE_DIR:
        os.makedirs(STORAGE_DIR, exist_ok=True)
        index.storage_context.persist(persist_dir=STORAGE_DIR)
        print(f"   ✓ Índice persistido en {STORAGE_DIR}")
    
    print("✅ Pipeline LlamaIndex RAG configurado\n")
    return index

def query_llamaindex(index, question: str):
    """
    Hace una query al pipeline RAG
    
    Args:
        index: Índice de LlamaIndex configurado
        question: Pregunta a responder
    """
    print(f"❓ Pregunta: {question}")
    print("🔍 Buscando respuesta...\n")
    
    query_engine = index.as_query_engine(
        similarity_top_k=3  # Top 3 chunks más relevantes
    )
    
    respuesta = query_engine.query(question)
    print(f"💬 Respuesta:\n{respuesta}\n")
    return respuesta

if __name__ == "__main__":
    # Ejemplo de uso
    print("=" * 60)
    print("LlamaIndex RAG con Qdrant + Ollama")
    print("=" * 60 + "\n")
    
    # Setup (solo primera vez o si cambian documentos)
    index = setup_llamaindex_rag()
    
    # Ejemplos de queries
    queries = [
        "¿Qué es RAG?",
        "¿Cuáles son las ventajas de usar LlamaIndex?",
        "¿Cómo funciona la indexación de documentos?"
    ]
    
    for query in queries:
        query_llamaindex(index, query)
        print("-" * 60 + "\n")

