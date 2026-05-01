#!/usr/bin/env python3

import json


def query_rag(question: str) -> dict:
    return {
        "question": question,
        "answer": "Respuesta sintetizada con evidencia",
        "citations": [
            {"source": "runbook_api.md", "chunk_id": "rbk-14"},
            {"source": "postmortem_2026_04.md", "chunk_id": "pm-03"}
        ]
    }


if __name__ == "__main__":
    out = query_rag("¿Cómo reducir latencia en API gateway?")
    print(json.dumps(out, ensure_ascii=False, indent=2))
