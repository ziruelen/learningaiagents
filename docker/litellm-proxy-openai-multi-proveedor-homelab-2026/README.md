# LiteLLM: proxy OpenAI-compatible en homelab

Ejemplos para la guía en [ElDiarioIA.es](https://www.eldiarioia.es): despliegue mínimo del **LiteLLM Proxy** con Docker Compose, `model_list` para Ollama y variables de entorno para secretos.

## Requisitos

- Docker + Docker Compose plugin
- Ollama accesible desde el contenedor (`OLLAMA_API_BASE`; en Linux suele usarse `host-gateway` como en el compose)
- Clave `LITELLM_MASTER_KEY` con prefijo `sk-` (ver documentación oficial)

## Uso rápido

```bash
cp .env.example .env
# Edita .env y litellm_config.yaml
docker compose up -d
curl -sS http://127.0.0.1:4000/v1/models -H "Authorization: Bearer $LITELLM_MASTER_KEY"
```

## Enlaces

- [LiteLLM Docker quick start](https://docs.litellm.ai/docs/proxy/docker_quick_start)
- [Config proxy](https://docs.litellm.ai/docs/proxy/configs)
- Repositorio LiteLLM: https://github.com/BerriAI/litellm
