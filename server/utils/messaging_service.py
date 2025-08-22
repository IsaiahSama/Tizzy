"""This module contains the implementation of the firebase messaging service."""

from firebase_admin import messaging

class MessagingService:
    
    @staticmethod
    def notify_user(receiver_token: str, payload: dict):
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
            token=receiver_token,
        )
        
        try:
            _ = messaging.send(message)
        except Exception as e:
            print(f"Error sending message: {e}")