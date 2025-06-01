# Tizzy Server

The Tizzy server is a web server designed to facilitate having Tizzy members be able to interact with each other.

The aim is to simply act as an intermediary source for the triggering of Firebase messages to interact from one partner's phone to the other.

The server will have a simple structure, designed using Python using FastAPI, to ensure faster cold start times, and simple development.

This API will be developed using:

- FastAPI
- MongoDB
- Firebase Messaging

## Routes

The routes will be done simply, for the most part, just to perform formatting on the different types of messages to be sent from one device to another.

There will also be a registration route, which will bind a device ID to its' FCM registration token. A registered device will have the following fields:

```py
class Device(BaseModel):
    deviceID: str
    fcmKey: str
    pairedFCMKey: str | None
```

Most other routes will have the following signature:

```py
def route(request: Request, body: FormData)
```

Where `FormData` is a Pydantic base model with the `json` structure of:

```json
{
    "sender": "senderID",
    "target": "receiverID",
    "type": "messageType",
    "data": "data to transmit"
}
```

Where `data` is a dictionary of predefined type, that will be directly transmitted to the phone with ID of `target`.

If no `target` is provided, then the recipient will be the sender's paired device.

For clarity, this can be expressed as the following model:

```py
class FormData(BaseModel):
    sender: str
    target: str | None
    type: str
    data: dict[str, str|int]
```