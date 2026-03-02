#!/usr/bin/env python3
"""OpenAI Agents SDK con Ollama (base_url local). Requiere: ollama serve y ollama pull llama3.2."""
from openai import AsyncOpenAI
from agents import Agent, Runner, set_default_openai_client, set_tracing_disabled

set_tracing_disabled(True)

client = AsyncOpenAI(
    base_url="http://localhost:11434/v1",
    api_key="ollama",
)
set_default_openai_client(client)

agent = Agent(
    name="Local",
    instructions="You are a helpful assistant.",
    model="llama3.2",
)
result = Runner.run_sync(agent, "Say hello in one sentence.")
print(result.final_output)
