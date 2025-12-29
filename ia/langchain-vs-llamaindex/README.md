# LangChain vs LlamaIndex - Ejemplos RAG para Homelab

## 📋 Descripción

Ejemplos de código y configuraciones del artículo **"LangChain vs LlamaIndex: Framework RAG para Homelab (Guía Comparativa 2025)"** publicado en [ElDiarioIA.es](https://www.eldiarioia.es).

Este repositorio contiene implementaciones funcionales de sistemas RAG usando ambos frameworks con Qdrant (vector database) y Ollama (LLM local).

## 📁 Estructura

```
langchain-vs-llamaindex/
├── docker-compose.langchain.yml    # Stack completo LangChain
├── docker-compose.llamaindex.yml   # Stack completo LlamaIndex
├── scripts/
│   ├── langchain_rag_example.py   # Ejemplo funcional LangChain
│   └── llamaindex_rag_example.py  # Ejemplo funcional LlamaIndex
├── configs/
│   └── rag_config.yaml             # Configuración compartida
└── README.md
```

## 🚀 Uso Rápido

### Prerrequisitos

- Docker y Docker Compose instalados
- GPU NVIDIA (opcional, recomendado para Ollama)
- Al menos 8GB RAM libre

### Opción 1: LangChain

```bash
# 1. Clonar o descargar este repositorio
cd langchain-vs-llamaindex

# 2. Crear directorio de datos
mkdir -p data
echo "Tu contenido aquí..." > data/documents.txt

# 3. Levantar servicios
docker-compose -f docker-compose.langchain.yml up -d

# 4. Esperar a que Ollama descargue modelos (primera vez)
docker logs -f ollama-langchain

# 5. Ejecutar ejemplo
docker exec -it langchain-rag python scripts/langchain_rag_example.py
```

### Opción 2: LlamaIndex

```bash
# 1. Clonar o descargar este repositorio
cd langchain-vs-llamaindex

# 2. Crear directorio de datos
mkdir -p data
echo "Tu contenido aquí..." > data/documents.txt

# 3. Levantar servicios
docker-compose -f docker-compose.llamaindex.yml up -d

# 4. Esperar a que Ollama descargue modelos (primera vez)
docker logs -f ollama-llamaindex

# 5. Ejecutar ejemplo
docker exec -it llamaindex-rag python scripts/llamaindex_rag_example.py
```

## 🔧 Configuración

Edita `configs/rag_config.yaml` para ajustar:

- **Modelos Ollama**: Cambia `ollama.model` y `ollama.embedding_model`
- **Qdrant**: Ajusta URL y puerto si es necesario
- **Chunking**: Modifica `documents.chunk_size` y `chunk_overlap`
- **Retrieval**: Ajusta `retrieval.top_k` para más/menos chunks

## 📚 Modelos Ollama Recomendados

```bash
# LLM principal
ollama pull llama3

# Embeddings
ollama pull nomic-embed-text
```

Alternativas:
- `mistral`, `neural-chat`, `codellama` (LLMs)
- `all-minilm` (embeddings más pequeños)

## 🐛 Troubleshooting

### Error: "Connection refused" con Qdrant

```bash
# Verificar que Qdrant esté corriendo
docker ps | grep qdrant

# Si no está, reiniciar
docker-compose -f docker-compose.langchain.yml restart qdrant
```

### Error: "Model not found" en Ollama

```bash
# Listar modelos disponibles
docker exec -it ollama-langchain ollama list

# Descargar modelo faltante
docker exec -it ollama-langchain ollama pull llama3
```

### Out of Memory

- Reduce `chunk_size` en `rag_config.yaml`
- Usa modelos más pequeños (ej: `mistral` en lugar de `llama3`)
- Aumenta swap o RAM disponible

## 📖 Artículo Completo

Para entender las diferencias entre LangChain y LlamaIndex, cuándo usar cada uno, y mejores prácticas, lee el artículo completo:

**[LangChain vs LlamaIndex: Framework RAG para Homelab (Guía Completa 2025)](https://www.eldiarioia.es)**

## 🔗 Enlaces Relacionados

- [Qdrant Documentation](https://qdrant.tech/documentation/)
- [Ollama Documentation](https://ollama.ai/docs)
- [LangChain Documentation](https://python.langchain.com/)
- [LlamaIndex Documentation](https://docs.llamaindex.ai/)

## 📝 Licencia

Estos ejemplos son de código abierto y están disponibles para uso educativo y personal.

---

**¿Preguntas o problemas?** Abre un issue en el repositorio o consulta el artículo completo.

