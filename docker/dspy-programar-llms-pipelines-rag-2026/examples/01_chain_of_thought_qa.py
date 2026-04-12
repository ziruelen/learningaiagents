"""
Ejemplo mínimo DSPy: QA con contexto (patrón RAG-lite).
Ajusta dspy.LM(...) según documentación vigente de dspy.ai y tu proveedor.
"""
import os

import dspy


class ContextQA(dspy.Signature):
    """Responde la pregunta usando únicamente el contexto proporcionado."""

    context: str = dspy.InputField(desc="Fragmentos recuperados")
    question: str = dspy.InputField()
    answer: str = dspy.OutputField()


def main() -> None:
    api_key = os.getenv("OPENAI_API_KEY", "")
    if not api_key:
        raise SystemExit("Define OPENAI_API_KEY (o adapta el LM a Ollama/local según docs DSPy).")

    # Modelo de ejemplo; cámbialo por el que uses en homelab.
    lm = dspy.LM("openai/gpt-4o-mini", api_key=api_key)
    dspy.configure(lm=lm)

    cot = dspy.ChainOfThought(ContextQA)
    ctx = "El servicio corre en el puerto 8080 y usa PostgreSQL 16."
    out = cot(context=ctx, question="¿Qué base de datos menciona el contexto?")
    print(out.answer)


if __name__ == "__main__":
    main()
