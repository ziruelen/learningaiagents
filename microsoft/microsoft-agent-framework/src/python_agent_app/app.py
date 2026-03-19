import os
import asyncio

from dotenv import load_dotenv
from azure.identity import AzureCliCredential

# Client Azure para Agent Framework (si usas otro provider, cambia el client)
from agent_framework.azure import AzureOpenAIResponsesClient

from tools import get_homelab_metric


async def main() -> None:
    load_dotenv()

    # Variables esperadas por los snippets oficiales de Microsoft Learn
    project_endpoint = os.environ["AZURE_AI_PROJECT_ENDPOINT"]
    deployment_name = os.environ["AZURE_OPENAI_RESPONSES_DEPLOYMENT_NAME"]

    credential = AzureCliCredential()

    client = AzureOpenAIResponsesClient(
        project_endpoint=project_endpoint,
        deployment_name=deployment_name,
        credential=credential,
    )

    # Agent: instrucciones + tools
    agent = client.as_agent(
        name="HomelabOpsAgent",
        instructions=(
            "Eres un assistant tecnico de SRE. "
            "Cuando el usuario pida un metric, usa la tool get_homelab_metric. "
            "Responde con datos claros y pasos de depuracion."
        ),
        tools=get_homelab_metric,
    )

    # 1) Session (persistencia de estado entre runs)
    session = agent.create_session()
    await agent.run("Mi nombre es Alice. Luego dime un resumen de mi homelab.", session=session)

    # 2) Non-streaming run
    result = await agent.run("Dame un estimado de CPU y RAM para mis operaciones homelab.", session=session)
    print("\n--- Non-streaming result ---")
    print(result.text)

    # 3) Streaming run (respuesta por partes)
    print("\n--- Streaming result ---")
    async for chunk in agent.run("Ejecuta un plan breve: primero CPU, luego disk. Usa la tool.", session=session, stream=True):
        if chunk.text:
            print(chunk.text, end="", flush=True)
    print()


if __name__ == "__main__":
    asyncio.run(main())

