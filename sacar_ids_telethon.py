#!/home/z/telethon/.venv/bin/python

from telethon.sync import TelegramClient

api_id =  "api-id"  # tu api_id aquí
api_hash = 'api-hash'

with TelegramClient('mi_sesion', api_id, api_hash) as client:
    print("Listado de TODOS los chats (grupos, canales, particulares, bots):")
    for dialog in client.iter_dialogs():
        tipo = []
        if dialog.is_user:
            tipo.append("Particular/Bot")
        if dialog.is_group:
            tipo.append("Grupo")
        if dialog.is_channel:
            tipo.append("Canal")
        tipos = ", ".join(tipo) if tipo else "Otro"
        print(f"{dialog.name} | ID: {dialog.id} | Tipo: {tipos}")
