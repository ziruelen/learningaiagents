# Integración de Flowise con Vector Databases

## Qdrant (Recomendado para Homelab)

### Setup Qdrant:
```yaml
# docker-compose.yml
services:
  qdrant:
    image: qdrant/qdrant:latest
    ports:
      - "6333:6333"
    volumes:
      - qdrant_data:/qdrant/storage
```

### En Flowise:
1. Añadir nodo "Vector Store"
2. Seleccionar "Qdrant"
3. Configurar:
   - **URL**: `http://qdrant:6333` (Docker network) o `http://localhost:6333`
   - **Collection**: Nombre de la colección (ej: `documents`)

## ChromaDB (Simple, Python-first)

### Setup ChromaDB:
```yaml
services:
  chromadb:
    image: chromadb/chroma:latest
    ports:
      - "8000:8000"
```

### En Flowise:
1. Seleccionar "ChromaDB" en Vector Store
2. URL: `http://chromadb:8000`

## Pinecone (Cloud, Managed)

### En Flowise:
1. Seleccionar "Pinecone"
2. Configurar API Key desde Pinecone dashboard
3. Seleccionar index

## Weaviate (Avanzado, GraphQL)

### Setup Weaviate:
```yaml
services:
  weaviate:
    image: semitechnologies/weaviate:latest
    ports:
      - "8080:8080"
```

### En Flowise:
1. Seleccionar "Weaviate"
2. URL: `http://weaviate:8080`

## Comparativa Rápida

| DB | Setup | Escalabilidad | Uso recomendado |
|----|-------|----------------|-----------------|
| Qdrant | Fácil | Alta | Homelab, producción |
| ChromaDB | Muy fácil | Media | Prototipos |
| Pinecone | Cloud | Muy alta | Producción cloud |
| Weaviate | Media | Alta | Casos avanzados |

