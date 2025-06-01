# Tizzy Server

The Tizzy server is a web server designed to facilitate having Tizzy members be able to interact with each other.

The aim is to simply act as an intermediary source for the triggering of Firebase messages to interact from one partner's phone to the other.

The server will have a simple structure, designed using Python using FastAPI, to ensure faster cold start times, and simple development.

## Routes

The routes will be done simply, just to perform formatting on the different types of messages to be sent from one device to another.

Each route will have the following signature:

```py
def route(Request, FormData)
```

Where `FormData` is a Pydantic base model with the `json` structure of:

```json
{
    "sender": "senderID",
    "receiver": "receiverID",
    "type": "messageType",
    "data": "data to transmit"
}
```

Where `data` is a dictionary of predefined type, that will be directly transmitted to the phone with ID of `receiver`.