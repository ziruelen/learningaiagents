FROM python:3.11-slim

WORKDIR /app

# Instalar dependencias
RUN pip install --no-cache-dir \
    crewai \
    langchain-community \
    langchain-openai \
    duckduckgo-search

# Copiar aplicación
COPY . /app

CMD ["python", "main.py"]
