"""This module contains the implementation of the firebase messaging service."""

from firebase_admin import messaging

class MessagingService:
    
    @staticmethod
    def notify_user(token: str, payload: dict):
        notification = messaging.Notification(
            title="Tizzy!",
            body="You've been Tizzed!",
            image="https://raw.githubusercontent.com/IsaiahSama/LoveWatch/refs/heads/main/assets/tizzy_logo.png?token=GHSAT0AAAAAAC5SJ6WDN6GSUMW2EFK3IHJ22B4XEYQ"
        )
        
        message = messaging.Message(
            data=payload,
            notification=notification,
            token=token,
        )

        _ = messaging.send(message)