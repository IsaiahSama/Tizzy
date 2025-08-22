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

    db_name: str = "TizzyDB"
    users_table: str = "users"
    companions_table: str = "companions"
    hrm_table: str = "hrm"

    db: AsyncIOMotorDatabase[Any]
    users_db: AsyncIOMotorCollection[dict[str, str]]
    companions_db: AsyncIOMotorCollection[dict[str, str]]
    hrm_db: AsyncIOMotorCollection[dict[str, str | int]]

    def __init__(self):
        self.connect()

    def connect(self):
        self.client = AsyncIOMotorClient(getenv("MONGODB_URL"))

        self.db = self.client.get_database(self.db_name)

        self.users_db = self.db.get_collection(self.users_table)
        self.companions_db = self.db.get_collection(self.companions_table)
        self.hrm_db = self.db.get_collection(self.hrm_table)

    async def register_device(self, device_id: str, fcm_key: str) -> OperationStatus:
        if await self.users_db.find_one({"device_id": device_id}) is not None:
            return OperationStatus(409, "Device already registered.")
        await self.users_db.insert_one({"device_id": device_id, "fcm_key": fcm_key})
        return OperationStatus(200, "Device registered successfully.")
    
    async def register_companion(self, device_id: str, fcm_key: str, companion_id: str) -> OperationStatus:
        companion = await self.users_db.find_one({"device_id": companion_id})
        
        if companion is None:
            return OperationStatus(404, "Device not found.")
        
        sender = await self.users_db.find_one({"device_id": device_id, "fcm_key": fcm_key})
        
        if sender is None:
            await self.register_device(device_id, fcm_key)

        if (await self.companions_db.find_one({"$or": [{"partner_1": companion_id}, {"partner_2": companion_id}]}) is not None):
            return OperationStatus(409, "Companion already registered. Find your own!")

        await self.companions_db.insert_one({"partner_1": companion_id, "partner_2": device_id})
        return OperationStatus(200, "Companion registered successfully.")
    
    async def delete_device(self, device_id: str, fcm_key: str) -> OperationStatus:
        if await self.users_db.find_one({"device_id": device_id, "fcm_key": fcm_key}) is None:
            return OperationStatus(404, "Device not found.")
        await self.users_db.delete_one({"device_id": device_id, "fcm_key": fcm_key})
        await self.companions_db.delete_many({"$or": [{"partner_1": device_id}, {"partner_2": device_id}]})
        return OperationStatus(200, "Device deleted successfully.")

    async def get_health(self, device_id: str) -> dict | None:
        health_entry = await self.hrm_db.find_one({"device_id": device_id})
        return health_entry

    async def store_health(self, device_id: str, hrm: int, activity: str) -> None:
        last_health = await self.get_health(device_id)

        if last_health is None:
            await self.hrm_db.insert_one({"device_id": device_id, "bpm": hrm, "activity": activity})
        else:
            await self.hrm_db.update_one({"device_id": device_id}, {"$set": {"bpm": hrm, "activity": activity}})

    async def get_user_and_companion(self, sender_id: str) -> tuple[dict, dict | None]:
        user = await self.users_db.find_one({"device_id": sender_id})
        if user is None:
            return {"message": "Sender not found."}, None

        companion_entry = await self.companions_db.find_one(
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

client = MongoClient()