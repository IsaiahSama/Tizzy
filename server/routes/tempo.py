"""This file will hold the routes for the Tempo application"""

from typing import Annotated
from fastapi import APIRouter, Form
from fastapi.responses import JSONResponse
from pydantic import BaseModel


try:
    from server.utils.mongo_db import client
    from server.utils.messaging_service import MessagingService
except ImportError:
    from utils.mongo_db import client
    from utils.messaging_service import MessagingService

router = APIRouter(prefix="/tempo", tags=["Tempo"])

class TempoMessage(BaseModel):
    sender_id: str
    message: str
    color: str | None

@router.post("/notify")
async def notify(data: Annotated[TempoMessage, Form()]):
    sender = await client.users_db.find_one({"device_id": data.sender_id})
    if sender is None:
        return JSONResponse(content={"message": "Sender not found."}, status_code=404)

    companion_entry = await client.companions_db.find_one(
        {"$or": [{"partner_1": data.sender_id}, {"partner_2": data.sender_id}]}
    )
    if companion_entry is None:
        return JSONResponse(content={"message": "No companion found."}, status_code=404)

    companion_id = (
        companion_entry["partner_1"]
        if companion_entry["partner_2"] == data.sender_id
        else companion_entry["partner_2"]
    )
    
    companion = await client.users_db.find_one({"device_id": companion_id})
    if companion is None:
        return JSONResponse(content={"message": "Companion not found."}, status_code=404)

    MessagingService.notify_user(companion["fcm_key"], {
        "type": "tempo",
        "message": data.message,
        "color": data.color or "default",
    })
    
    print(f"sender: {sender}, companion: {companion}")
    
    return JSONResponse(content={"message": "Notification sent."}, status_code=200)

