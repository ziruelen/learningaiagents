#!/usr/bin/env python3
import os
from langfuse import Langfuse

lf = Langfuse(
    public_key=os.getenv("LANGFUSE_PUBLIC_KEY", "pk-lf-example"),
    secret_key=os.getenv("LANGFUSE_SECRET_KEY", "sk-lf-example"),
    host=os.getenv("LANGFUSE_HOST", "http://localhost:3000"),
)

trace = lf.trace(name="chat-request", user_id="demo-user")
span = trace.span(name="llm-call", input={"prompt": "hola"})
span.end(output={"answer": "hola desde ejemplo"})

print("Trace de ejemplo enviado")
