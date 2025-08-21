"""This module contains the implementation of the firebase messaging service."""

from firebase_admin import messaging

class MessagingService:
    
    @staticmethod
    def notify_user(token: str, payload: dict):
        notification = messaging.Notification(
            title="Tizzy: " + payload.get("title", "!"),
            body=payload.get("body", None) or payload.get("message", None) or "You've been Tizzed!",
            image="https://i.imgur.com/w3L9zVh.png"
        )
        
        android = messaging.AndroidConfig(
            priority="high",
        )
        
        message = messaging.Message(
            data=payload,
            notification=notification,
            android=android,
            token=token,
        )

        _ = messaging.send(message)