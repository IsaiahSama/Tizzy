from typing import Annotated
from fastapi import FastAPI, Form
from fastapi.responses import JSONResponse
from pydantic import BaseModel


try:
    from server.routes import tempo
    from server.utils.mongo_db import MongoClient
    from server.utils.operation_status import OperationStatus
except ImportError:
    from routes import tempo
    from utils.mongo_db import MongoClient
    from utils.operation_status import OperationStatus

app = FastAPI()

client = MongoClient()

app.include_router(tempo.router)

@app.get("/ping") # This suffices as a health check
async def ping():
    return {"message": "pong"}

class UploadDeviceModel(BaseModel):
    
    """
    A model representing a device that is registering to join the system.
    """
    
    device_id: str
    fcm_key: str

@app.get("/register") 
async def register(data: Annotated[UploadDeviceModel, Form()]):
    result: OperationStatus = await client.register_device(data.device_id, data.fcm_key)
    return JSONResponse(content={"message": result.reason}, status_code=result.status_code)
    
class CompanionModel(BaseModel):
    
    """
    A model representing a companion to be assigned to the sender.
    """
    
    device_id: str
    fcm_key: str
    companion_fcm_key: str
    
@app.post("/companion")
async def register_companion(data: Annotated[CompanionModel, Form()]):
    result: OperationStatus = await client.register_companion(data.device_id, data.fcm_key, data.companion_fcm_key)
    return JSONResponse(content={"message": result.reason}, status_code=result.status_code)

