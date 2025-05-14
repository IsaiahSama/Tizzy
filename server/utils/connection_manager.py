"""This will be the manager for all socket connections"""

from starlette.websockets import WebSocket


class ConnectionManager:
    def __init__(self):
        self.active_connections: list[WebSocket] = []

    async def connect(self, websocket: WebSocket):
        await websocket.accept()
        self.active_connections.append(websocket)

    def disconnect(self, websocket: WebSocket):
        self.active_connections.remove(websocket)

    async def send_tempo(self, tempo_id: str, sender: WebSocket):
        for connection in self.active_connections:
            if connection != sender:
                await connection.send_text(str(tempo_id))

    async def broadcast(self, message: str):
        for connection in self.active_connections:
            await connection.send_text(message)

    async def reply(self, message: str, sender: WebSocket):
        await sender.send_text(message)
