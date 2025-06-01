"""This class will handle the connection and maintenance of the database."""

from os import getenv
from typing import Any

from motor.motor_asyncio import (
    AsyncIOMotorClient,
    AsyncIOMotorCollection,
    AsyncIOMotorDatabase,
)

try:
    from server.utils.operation_status import OperationStatus
except ImportError:
    from utils.operation_status import OperationStatus

class MongoClient:
    """
    This class represents a connection to the Mongo Database
    """

    client: AsyncIOMotorClient[Any]

    db_name: str = "BajanInsiderMongoDB"
    users_table: str = "users"
    companions_table: str = "companions"

    db: AsyncIOMotorDatabase[Any]
    users_db: AsyncIOMotorCollection[dict[str, str]]
    companions_db: AsyncIOMotorCollection[dict[str, str]]

    def __init__(self):
        self.connect()

    def connect(self):
        self.client = AsyncIOMotorClient(getenv("MONGODB_URL"))

        self.db = self.client.get_database(self.db_name)

        self.users_db = self.db.get_collection(self.users_table)
        self.companions_db = self.db.get_collection(self.companions_table)
        
    async def register_device(self, device_id: str, fcm_key: str) -> OperationStatus:
        if await self.users_db.find_one({"device_id": device_id}) is not None:
            return OperationStatus(409, "Device already registered.")
        await self.users_db.insert_one({"device_id": device_id, "fcm_key": fcm_key})
        return OperationStatus(200, "Device registered successfully.")
    
    async def register_companion(self, device_id: str, fcm_key: str, companion_fcm_key: str) -> OperationStatus:
        companion = await self.users_db.find_one({"fcm_key": companion_fcm_key})
        if companion is None:
            return OperationStatus(404, "Device not found.")
        sender = await self.users_db.find_one({"device_id": device_id, "fcm_key": fcm_key})
        if sender is None:
            await self.register_device(device_id, fcm_key)
            
        if (await self.companions_db.find_one({"$or": [{"partner_1": companion_fcm_key}, {"partner_2": companion_fcm_key}]}) is not None):
            return OperationStatus(409, "Companion already registered. Find your own!")
            
        await self.companions_db.insert_one({"partner_1": companion_fcm_key, "partner_2": fcm_key})
        return OperationStatus(200, "Companion registered successfully.")
        
