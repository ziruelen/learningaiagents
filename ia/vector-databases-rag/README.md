# Vector Databases para RAG: Ejemplos Prácticos

Ejemplos de código y configuraciones Docker para integrar Vector Databases (Qdrant, Pinecone, Weaviate, ChromaDB) en sistemas RAG.

## 📋 Descripción

Este repositorio contiene ejemplos funcionales para las principales bases de datos vectoriales usadas en sistemas de Retrieval-Augmented Generation (RAG).

## 🚀 Inicio Rápido

### 1. Qdrant

```bash
docker-compose -f docker-compose.qdrant.yml up -d
```

- REST API: http://localhost:6333
- Dashboard: http://localhost:6333/dashboard

### 2. Weaviate

```bash
docker-compose -f docker-compose.weaviate.yml up -d
```

- API: http://localhost:8080/v1

### 3. ChromaDB

```bash
docker-compose -f docker-compose.chromadb.yml up -d
```

- API: http://localhost:8000

## 📁 Archivos

- `docker-compose.qdrant.yml` - Configuración Docker para Qdrant
- `docker-compose.weaviate.yml` - Configuración Docker para Weaviate
- `docker-compose.chromadb.yml` - Configuración Docker para ChromaDB
- `rag_integration_example.py` - Ejemplo de integración RAG con LangChain

## 💻 Uso

Ver el ejemplo en `rag_integration_example.py` para ver cómo integrar cada vector database con LangChain y RAG.

## 📚 Artículo Completo

Guía completa: [Vector Databases para RAG: Qdrant vs Pinecone vs Weaviate vs ChromaDB](https://www.eldiarioia.es/2025/12/16/vector-databases-rag-qdrant-pinecone-weaviate-chromadb/)

---

**Nota:** Para Pinecone, usa el servicio managed en https://www.pinecone.io/ (no requiere Docker local).

