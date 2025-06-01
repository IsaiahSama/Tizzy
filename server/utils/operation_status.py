"""This will represent an OperationStatus for an operation."""

class OperationStatus:
    """This will represent an OperationStatus for an operation."""
    
    success: bool
    status_code: int
    reason: str
    
    def __init__(self, status_code, reason):
        self.status_code = status_code
        self.reason = reason
        
        self.success = status_code >= 200 and status_code < 300