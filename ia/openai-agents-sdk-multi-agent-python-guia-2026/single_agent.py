#!/usr/bin/env python3
"""Ejemplo mínimo: un agente con OpenAI Agents SDK."""
import asyncio
from agents import Agent, Runner


async def main():
    agent = Agent(
        name="Assistant",
        instructions="You are a helpful assistant. Answer concisely.",
    )
    result = await Runner.run(agent, "Write a one-line haiku about Python.")
    print(result.final_output)


if __name__ == "__main__":
    asyncio.run(main())
