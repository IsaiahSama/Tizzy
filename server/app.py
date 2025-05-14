from fastapi import FastAPI
from server.routes import tempo

app = FastAPI()

app.include_router(tempo.router)


@app.get("/ping")
async def ping():
    return {"message": "pong"}
