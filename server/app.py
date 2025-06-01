from fastapi import FastAPI

try:
    from server.routes import tempo
    from server.utils.mongo_db import MongoClient
except ImportError:
    from routes import tempo
    from utils.mongo_db import MongoClient

app = FastAPI()

client = MongoClient()

app.include_router(tempo.router)

@app.get("/ping")
async def ping():
    return {"message": "pong"}
