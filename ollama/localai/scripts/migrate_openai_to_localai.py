#!/usr/bin/env python3
"""
Script para migrar código de OpenAI a LocalAI
Uso: python3 migrate_openai_to_localai.py archivo.py
"""
import re
import sys

def migrate_openai_to_localai(file_path):
    """Migra un archivo Python de OpenAI a LocalAI"""
    with open(file_path, 'r') as f:
        content = f.read()
    
    # Reemplazar URL base
    content = re.sub(
        r'base_url=["\']https://api\.openai\.com/v1["\']',
        'base_url="http://localhost:8080/v1"',
        content
    )
    
    # Reemplazar API key (opcional, LocalAI no la requiere)
    content = re.sub(
        r'api_key=["\']sk-[^"\']+["\']',
        'api_key="not-needed"',
        content
    )
    
    output_path = file_path + '.localai'
    with open(output_path, 'w') as f:
        f.write(content)
    
    print(f"✅ Migrado: {file_path} -> {output_path}")

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Uso: python3 migrate_openai_to_localai.py <archivo.py>")
        sys.exit(1)
    
    migrate_openai_to_localai(sys.argv[1])

