try:
    from .connection_manager import ConnectionManager
except ImportError:
    from connection_manager import ConnectionManager

__all__ = ["ConnectionManager"]
