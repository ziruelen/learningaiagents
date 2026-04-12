# Hugging Face TGI (Text Generation Inference) — ejemplos Docker

Servidor **text generation inference** con la imagen oficial `ghcr.io/huggingface/text-generation-inference`.

## Aviso

El upstream declara **modo mantenimiento**; para proyectos nuevos compara con vLLM/SGLang. Ver guía en ElDiarioIA.

## Uso

```bash
cp configs/env.example .env
# Edita .env (MODEL_ID, HF_TOKEN si aplica)
docker compose up -d
```

## Prueba rápida

```bash
chmod +x scripts/smoke.sh
./scripts/smoke.sh 127.0.0.1 8080
curl -s "http://127.0.0.1:8080/generate" -H "Content-Type: application/json" \
  -d '{"inputs":"Hello","parameters":{"max_new_tokens":16}}' | head -c 400
```

## Documentación

- https://huggingface.co/docs/text-generation-inference/
