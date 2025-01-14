from functools import partial
import asyncio
import websockets
import os
import time

# Variable global para rastrear el último comando ejecutado y su tiempo
ultimo_comando = None
tiempo_ultimo_comando = 0

# La función ahora no necesita 'path'
async def manejar_comando(websocket):
    global ultimo_comando, tiempo_ultimo_comando

    print("Cliente conectado.")
    try:
        async for mensaje in websocket:
            print(f"Comando recibido: {mensaje}")
            
            tiempo_actual = time.time()
            if mensaje == ultimo_comando and (tiempo_actual - tiempo_ultimo_comando < 2):
                print(f"Ignorando comando repetido: {mensaje}")
                continue 
            
            ultimo_comando = mensaje
            tiempo_ultimo_comando = tiempo_actual

            # Ejecuta el comando
            if mensaje == "abrir_web":
                print("Abriendo página web...")
                os.system("start https://www.google.com")
            elif mensaje == "abrir_word":
                print("Abriendo Microsoft Word...")
                os.system("start winword")
            elif mensaje == "reproducir_video":
                print("Reproduciendo video...")
                os.system("start vlc")
            else:
                print(f"Comando desconocido: {mensaje}")
    except Exception as e:
        print(f"Error inesperado: {e}")

async def iniciar_servidor():
    print("Iniciando servidor WebSocket...")
    servidor = await websockets.serve(partial(manejar_comando), "192.168.117.71", 8765)
    print("Servidor WebSocket iniciado en ws://192.168.117.71:8765...")
    await servidor.wait_closed()

if __name__ == "__main__":
    try:
        asyncio.run(iniciar_servidor())
    except KeyboardInterrupt:
        print("\nServidor detenido manualmente.")
