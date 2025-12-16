#!/usr/bin/env python3
"""
Ejemplo de integración RAG con diferentes Vector Databases
Usa este ejemplo para comparar Qdrant, Pinecone, Weaviate y ChromaDB
"""

from langchain.text_splitter import RecursiveCharacterTextSplitter
from langchain.embeddings import HuggingFaceEmbeddings
from langchain.vectorstores import Qdrant, Chroma, Weaviate
from langchain.docstore.document import Document
from qdrant_client import QdrantClient
import weaviate

# Documentos de ejemplo
documents = [
    Document(page_content="Las bases de datos vectoriales permiten búsqueda semántica eficiente."),
    Document(page_content="RAG combina recuperación de información con generación de texto."),
    Document(page_content="Qdrant es una base de datos vectorial escrita en Rust."),
]

# Split documentos
text_splitter = RecursiveCharacterTextSplitter(chunk_size=500, chunk_overlap=50)
chunks = text_splitter.split_documents(documents)

# Embeddings
embeddings = HuggingFaceEmbeddings(
    model_name="sentence-transformers/all-MiniLM-L6-v2"
)


# ============================================
# OPCIÓN 1: Qdrant
# ============================================
def setup_qdrant():
    client = QdrantClient(host="localhost", port=6333)
    
    vectorstore = Qdrant(
        client=client,
        collection_name="rag_example",
        embeddings=embeddings
    )
    
    vectorstore.add_documents(chunks)
    
    # Búsqueda
    results = vectorstore.similarity_search("¿Qué es una base de datos vectorial?", k=2)
    print("Qdrant results:", [r.page_content[:50] for r in results])
    return vectorstore


# ============================================
# OPCIÓN 2: ChromaDB (Embedded Mode)
# ============================================
def setup_chromadb():
    vectorstore = Chroma.from_documents(
        documents=chunks,
        embedding=embeddings,
        persist_directory="./chroma_db"
    )
    
    # Búsqueda
    results = vectorstore.similarity_search("¿Qué es una base de datos vectorial?", k=2)
    print("ChromaDB results:", [r.page_content[:50] for r in results])
    return vectorstore


# ============================================
# OPCIÓN 3: Weaviate
# ============================================
def setup_weaviate():
    client = weaviate.Client("http://localhost:8080")
    
    vectorstore = Weaviate(
        client=client,
        index_name="RAGDocument",
        text_key="text",
        embedding=embeddings
    )
    
    vectorstore.add_documents(chunks)
    
    # Búsqueda
    results = vectorstore.similarity_search("¿Qué es una base de datos vectorial?", k=2)
    print("Weaviate results:", [r.page_content[:50] for r in results])
    return vectorstore


if __name__ == "__main__":
    print("🚀 Ejemplo de integración RAG con Vector Databases")
    print("\n1. Asegúrate de tener los servicios corriendo:")
    print("   - Qdrant: docker-compose -f docker-compose.qdrant.yml up -d")
    print("   - Weaviate: docker-compose -f docker-compose.weaviate.yml up -d")
    print("   - ChromaDB: docker-compose -f docker-compose.chromadb.yml up -d")
    print("\n2. Descomenta la opción que quieras probar:")
    print("   # setup_qdrant()")
    print("   # setup_chromadb()")
    print("   # setup_weaviate()")

