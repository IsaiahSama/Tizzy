from pydantic import BaseModel

class Device(BaseModel):
    device_id: str
    fcm_key: str
    paired_fcm_key: str