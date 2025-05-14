"""This file will hold the routes for the Tempo application"""

from fastapi import APIRouter
from starlette.websockets import WebSocket, WebSocketDisconnect
from server.utils import ConnectionManager

manager = ConnectionManager()

router = APIRouter(prefix="/ws/tempo")


@router.websocket("/ws/{client_id}")
async def tempo_endpoint(websocket: WebSocket):
    await manager.connect(websocket)

    try:
        while len(manager.active_connections) != 2:
            await manager.broadcast("Awaiting partner...")

        while True:
            data = await websocket.receive_text()
            if data.isnumeric():
                await manager.send_tempo(data, websocket)
            else:
                await manager.reply("Invalid message", websocket)
    except WebSocketDisconnect:
        manager.disconnect(websocket)
        await manager.broadcast("Partner Disconnected!")
