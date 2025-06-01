try:
    from .connection_manager import ConnectionManager
    from .messaging_service import MessagingService
except ImportError:
    from connection_manager import ConnectionManager
    from messaging_service import MessagingService
    
import firebase_admin

firebase_admin.initialize_app()

__all__ = ["ConnectionManager", "MessagingService"]
