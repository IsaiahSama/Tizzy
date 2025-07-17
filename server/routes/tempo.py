"""This file will hold the routes for the Tempo application"""

from typing import Annotated
from fastapi import APIRouter, Form, Body
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
    
async def get_user_and_companion(sender_id: str) -> tuple[dict, dict | None]:
    user = await client.users_db.find_one({"device_id": sender_id})
    if user is None:
        return {"message": "Sender not found."}, None

    companion_entry = await client.companions_db.find_one(
        {"$or": [{"partner_1": sender_id}, {"partner_2": sender_id}]}
    )
    if companion_entry is None:
        return {"message": "No companion found."}, None

    companion_id = (
        companion_entry["partner_1"]
        if companion_entry["partner_2"] == sender_id
        else companion_entry["partner_2"]
    )
    
    companion = await client.users_db.find_one({"device_id": companion_id})
    return user, companion

@router.post("/notify")
async def notify(data: Annotated[TempoMessage, Form()]):
    sender_or_error, companion = await get_user_and_companion(data.sender_id)
    
    if not companion:
        error = sender_or_error
        return JSONResponse(content=error, status_code=404)
    
    sender = sender_or_error

    MessagingService.notify_user(companion["fcm_key"], {
        "type": "tempo",
        "message": data.message,
        "color": data.color or "default",
    })
    
    print(f"sender: {sender}, companion: {companion}")
    
    return JSONResponse(content={"message": "Notification sent."}, status_code=200)

@router.post("/w/notify", response_class=JSONResponse)
async def notify_json(body = Body(None)):
    message: str = body.get("message") or ""
    sender_id: str = body.get("sender_id") or ""
    color: str = body.get("color") or ""
    
    if message == "" or sender_id == "":
        return JSONResponse(content={"message": "No message provided."}, status_code=400)
    
    tmsg: TempoMessage = TempoMessage(
        sender_id=sender_id,
        message=message,
        color=color,
    )
    return await notify(tmsg)

class CompanionPulse(BaseModel):
    sender_id: str
    pulse: int
    activity: str

@router.post("/pulse")
async def pulse(data: Annotated[CompanionPulse, Form()]):
    sender_or_error, companion = await get_user_and_companion(data.sender_id)
    
    if not companion:
        error = sender_or_error
        return JSONResponse(content=error, status_code=404)
    
    await client.store_health(data.sender_id, data.pulse, data.activity)    
    
    return JSONResponse(content={"message": "Pulse data stored."}, status_code=200)

@router.post("/w/pulse", response_class=JSONResponse)
async def pulse_json(body = Body(None)):
    sender_pulse: int = body.get("bpm") or 0
    sender_id: str = body.get("sender_id") or ""
    activity: str = body.get("activity") or ""
    
    if sender_pulse <= 0 or sender_id == "":
        return JSONResponse(content={"message": "Invalid pulse data."}, status_code=400)
    
    companion_pulse = CompanionPulse(
        sender_id=sender_id,
        pulse=sender_pulse,
        activity=activity,
    )
    
    return await pulse(companion_pulse)
    
@router.get("/pulse/{device_id}")
async def get_companion_pulse(device_id: str):
    sender_or_error, companion = await get_user_and_companion(device_id)

    if not companion:
        error = sender_or_error
        return JSONResponse(content=error, status_code=404)

    self_health = await client.get_health(device_id)
    companion_health = await client.get_health(companion["device_id"])

    return JSONResponse(content={"self": self_health, "companion": companion_health}, status_code=200)