# BentoML + OpenLLM — homelab (referencia)

Material de apoyo para el artículo **bentoml openllm serving modelos** en [ElDiarioIA](https://www.eldiarioia.es/). OpenLLM se instala hoy principalmente vía **pip**; la imagen Docker histórica `ghcr.io/bentoml/openllm` aparece como no mantenida en [discusiones del proyecto](https://github.com/bentoml/OpenLLM/discussions/1021).

## Contenido

- `scripts/bootstrap-venv.sh` — crea venv e instala `openllm` con pin sugerido (edítalo).
- `configs/env.example` — variables `HF_TOKEN`, `CUDA_VISIBLE_DEVICES`, etc.

## Pasos rápidos

```bash
./scripts/bootstrap-venv.sh
source .venv/bin/activate
openllm hello
openllm model list
export HF_TOKEN=...   # solo modelos gated
openllm serve llama3.2:1b
```

Servidor por defecto en `http://127.0.0.1:3000` (API compatible OpenAI + `/chat` según README oficial).

## Documentación oficial

- [github.com/bentoml/OpenLLM](https://github.com/bentoml/OpenLLM)
- [github.com/bentoml/openllm-models](https://github.com/bentoml/openllm-models)
- [docs.bentoml.com](https://docs.bentoml.com/)
