#!/home/z/telethon/.venv/bin/python

import sys
import traceback
from telethon import TelegramClient
from telethon.errors.rpcerrorlist import ChatWriteForbiddenError

api_id = API-ID
api_hash = 'API-HASH'


if len(sys.argv) < 3:
    print("Uso: enviar_telegram.py <destino> <mensaje>", file=sys.stderr)
    sys.exit(1)

# Procesa el destino: si es un número, lo convierte a int
try:
    destino = int(sys.argv[1])
except ValueError:
    destino = sys.argv[1]  # Puede ser un username (@grupo_publico)
mensaje = sys.argv[2]

client = TelegramClient('mi_sesion', api_id, api_hash)

async def main():
    try:
        # Recorre los diálogos para asegurarse de que la sesión "ve" los grupos/canales
        print("Sincronizando diálogos...")
        dialogs = []
        async for dialog in client.iter_dialogs():
            dialogs.append((dialog.name, dialog.id))
        print("Diálogos encontrados:")
        for name, did in dialogs:
            print(f"  {name} | {did}")

        # Busca la entidad correspondiente
        print(f"Buscando entidad para destino: {destino}")
        entity = await client.get_entity(destino)

        # Envía el mensaje
        msg = await client.send_message(entity, mensaje)
        print(f"OK: enviado a '{entity.title if hasattr(entity, 'title') else entity.username}' el mensaje: '{mensaje}' (ID: {msg.id})")

    except ChatWriteForbiddenError:
        print("ERROR: No tienes permisos para escribir en ese grupo/canal.", file=sys.stderr)
        sys.exit(2)
    except Exception as e:
        print(f"ERROR: {str(e)}", file=sys.stderr)
        traceback.print_exc()
        sys.exit(1)

with client:
    client.loop.run_until_complete(main())
