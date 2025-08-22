"""This file will hold routes for sharing data between pairs outside of messages"""

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
    
router = APIRouter(prefix="/share", tags=["Share"])

class ShareCountdown(BaseModel):
    sender_id: str
    countdown_id: str
    title: str
    end_date: str
    completed: bool
    
@router.post("/countdown")
async def share_countdown(data: Annotated[ShareCountdown, Form()]):
    sender_or_error, companion = await client.get_user_and_companion(data.sender_id)
    
    if not companion:
        error = sender_or_error
        return JSONResponse(content=error, status_code=404)
    
    MessagingService.notify_user(
        companion['fcm_key'],
        {
            "type": "countdown",
            "countdown_id": data.countdown_id,
            "title": data.title,
            "end_date": data.end_date,
            "completed": str(data.completed).lower(),
        }
    )

    return JSONResponse(content={"message": "Countdown shared successfully."}, status_code=200)