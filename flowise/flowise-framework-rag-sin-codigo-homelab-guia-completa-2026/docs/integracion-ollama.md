# Integración de Flowise con Ollama

## Configuración

1. **Asegúrate de que Ollama está corriendo:**
   ```bash
   docker ps | grep ollama
   # O verificar: curl http://localhost:11434/api/tags
   ```

2. **En Flowise UI:**
   - Añadir nodo "Chat Model"
   - Seleccionar "Ollama" como provider
   - Configurar:
     - **Base URL**: `http://ollama:11434` (si mismo Docker network) o `http://host.docker.internal:11434`
     - **Model**: `llama3.2`, `mistral`, `qwen2.5`, etc.
     - **Temperature**: `0.7` (ajustar según necesidad)

3. **Verificar conexión:**
   - Probar con un mensaje simple en el chat de Flowise
   - Si falla, verificar red Docker o usar `host.docker.internal`

## Ejemplo de Flujo RAG con Ollama

1. Document Loader → Cargar PDFs/documentos
2. Text Splitter → Dividir en chunks (1000 chars, overlap 200)
3. Embeddings → Usar Ollama para generar embeddings
4. Vector Store → Almacenar en Qdrant/ChromaDB
5. Retrieval QA Chain → Usar Ollama como LLM

## Troubleshooting

- **Error "Cannot connect"**: Verificar que Ollama está accesible desde el contenedor Flowise
- **Timeout**: Usar modelos más pequeños o aumentar timeout
- **Memory**: Ollama necesita suficiente RAM/VRAM para el modelo

