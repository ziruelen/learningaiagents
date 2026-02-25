"""
Ejemplo conceptual: dos agentes con AutoGen (AgentChat) y Ollama.
Requiere: pip install autogen-core (o pyautogen según versión) y Ollama en marcha.
Configuración Ollama: Base URL http://localhost:11434/v1, model según ollama list.
"""
import os

# Configurar endpoint Ollama (compatible OpenAI)
os.environ.setdefault("OPENAI_BASE_URL", "http://localhost:11434/v1")
os.environ.setdefault("OPENAI_API_KEY", "dummy")
os.environ.setdefault("OPENAI_MODEL", "llama3.2")

# Ejemplo de uso (descomentar cuando tengas autogen instalado):
# import autogen
# config_list = [{"model": os.environ["OPENAI_MODEL"], "api_key": "dummy", "base_url": os.environ["OPENAI_BASE_URL"]}]
# llm_config = {"config_list": config_list}
# assistant = autogen.AssistantAgent(name="Assistant", llm_config=llm_config)
# user_proxy = autogen.UserProxyAgent(name="User", human_input_mode="NEVER", code_execution_config=False)
# user_proxy.initiate_chat(assistant, message="¿Qué es AutoGen en una frase?")

if __name__ == "__main__":
    print("Config Ollama:", os.environ.get("OPENAI_BASE_URL"), os.environ.get("OPENAI_MODEL"))
    print("Instala autogen-core o pyautogen y descomenta el bloque de código para ejecutar el chat.")
