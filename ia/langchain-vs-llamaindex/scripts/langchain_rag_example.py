#!/usr/bin/env python3
"""
Ejemplo LangChain RAG con Qdrant y Ollama
Basado en el artículo: LangChain vs LlamaIndex - Framework RAG para Homelab
"""

from langchain_community.vectorstores import Qdrant
from langchain_community.embeddings import OllamaEmbeddings
from langchain_community.llms import Ollama
from langchain.chains import RetrievalQA
from langchain.text_splitter import RecursiveCharacterTextSplitter
from langchain.document_loaders import TextLoader
import os

# Configuración
QDRANT_URL = os.getenv("QDRANT_URL", "http://localhost:6333")
OLLAMA_URL = os.getenv("OLLAMA_URL", "http://localhost:11434")
OLLAMA_MODEL = os.getenv("OLLAMA_MODEL", "llama3")
EMBEDDING_MODEL = os.getenv("EMBEDDING_MODEL", "nomic-embed-text")

def setup_langchain_rag(documents_path: str = "data/documents.txt"):
    """
    Configura pipeline RAG con LangChain
    
    Args:
        documents_path: Ruta al archivo de documentos
    """
    print("📚 Cargando documentos...")
    loader = TextLoader(documents_path)
    documents = loader.load()
    
    print("✂️ Dividiendo documentos en chunks...")
    text_splitter = RecursiveCharacterTextSplitter(
        chunk_size=1000,
        chunk_overlap=200
    )
    chunks = text_splitter.split_documents(documents)
    print(f"   ✓ {len(chunks)} chunks creados")
    
    print("🔗 Creando embeddings y vector store...")
    embeddings = OllamaEmbeddings(
        model=EMBEDDING_MODEL,
        base_url=OLLAMA_URL
    )
    
    vector_store = Qdrant.from_documents(
        chunks,
        embeddings,
        url=QDRANT_URL,
        collection_name="langchain_documents"
    )
    print("   ✓ Vector store creado en Qdrant")
    
    print("🤖 Configurando LLM...")
    llm = Ollama(
        model=OLLAMA_MODEL,
        base_url=OLLAMA_URL,
        request_timeout=120.0
    )
    
    print("🔗 Creando chain de RAG...")
    qa_chain = RetrievalQA.from_chain_type(
        llm=llm,
        chain_type="stuff",
        retriever=vector_store.as_retriever(
            search_kwargs={"k": 3}  # Top 3 chunks más relevantes
        )
    )
    
    print("✅ Pipeline LangChain RAG configurado\n")
    return qa_chain

def query_langchain(qa_chain, question: str):
    """
    Hace una query al pipeline RAG
    
    Args:
        qa_chain: Chain de LangChain configurado
        question: Pregunta a responder
    """
    print(f"❓ Pregunta: {question}")
    print("🔍 Buscando respuesta...\n")
    
    respuesta = qa_chain.run(question)
    print(f"💬 Respuesta:\n{respuesta}\n")
    return respuesta

if __name__ == "__main__":
    # Ejemplo de uso
    print("=" * 60)
    print("LangChain RAG con Qdrant + Ollama")
    print("=" * 60 + "\n")
    
    # Setup (solo primera vez o si cambian documentos)
    qa_chain = setup_langchain_rag()
    
    # Ejemplos de queries
    queries = [
        "¿Qué es RAG?",
        "¿Cuáles son las ventajas de usar LangChain?",
        "¿Cómo funciona la recuperación de información?"
    ]
    
    for query in queries:
        query_langchain(qa_chain, query)
        print("-" * 60 + "\n")

