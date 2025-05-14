# LoveWatch

This repository will hold all of the code for all of our applications for our watches 😍, each within their respective folders.

Apps located here include:

- ClockFace: Our custom Clock Application
- Tempo: Quick message interface. Will require a mobile app, and access to internet.
- ISeeYou: Application to monitor partner.

There will also be a server written using FastAPI to facilitate the watches communicating with each other, and accessing data from the other.
The server will provide services that can be used by each of the watches' applications.

## ClockFace

ClockFace will be our custom clock face, which will consist of two (2) parts:

- The time, date and day.
- Image, which will randomly cycle through images of us.

## Tempo

Tempo will provide a quick message interface to send messages to the other's watch.

Messages will include:

- I love you~
- I miss you
- Be safe!
- Tempo
- Check Phone!
- Call?
- I want you 🥴🥴

## ISeeYou

ISeeYou will provide several monitoring features for the partner such as:

- Location Tracking
- Heart Rate Monitoring

## Server
The server will have the following routes for the different applications:

### Tempo
The routes for the Tempo application will use websockets.
Once the connection is established, messages will consist of an integer, which will be used to index an array of messages to display.

WS: /ws/tempo/ - Establish a websocket connection with the watch.

