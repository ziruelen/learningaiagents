# DSPy — dspy programar llms pipelines (homelab)

Ejemplos mínimos para acompañar la guía en [ElDiarioIA](https://www.eldiarioia.es/). Instala siempre la versión de **DSPy** que documentes en tu `requirements.txt` (la API evoluciona entre major/minor).

## Requisitos

- Python 3.10+ recomendado.
- Claves/API de tu proveedor LM o endpoint local compatible (LiteLLM según doc DSPy).

## Contenido

- `requirements.txt` — pin sugerido.
- `examples/01_chain_of_thought_qa.py` — patrón RAG-lite (contexto + pregunta → respuesta).
- `configs/env.example` — variables de entorno (sin secretos reales).

## Uso rápido

```bash
python3 -m venv .venv && source .venv/bin/activate
pip install -r requirements.txt
cp configs/env.example .env   # edita claves
python examples/01_chain_of_thought_qa.py
```

## Documentación oficial

- [https://dspy.ai/](https://dspy.ai/)
- [https://github.com/stanfordnlp/dspy](https://github.com/stanfordnlp/dspy)
