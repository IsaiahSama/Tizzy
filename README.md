# Tizzy

This repository will hold all of the code for all of our applications for our watches 😍, each within their respective folders.

The repository is broken into three parts:

- Watch Applications (./watch)
- Server (./server)
- Mobile Application (./mobile)

Where:

- Watch Applications are applications developed for the watches
- Server is a web server used to provide functionality and communication between the devices.
- Mobile Application is the mobile application used to intergrate and facilitate communication between the watches and the server.

## Watch Applications

Apps located here include:

- ClockFace: Our custom Clock Application
- Tempo: Quick message interface. Will require a mobile app, and access to internet.
- ISeeYou: Application to monitor partner.

### ClockFace

ClockFace will be our custom clock face, which will consist of two (2) parts:

- The time, date and day.
- Image, which will randomly cycle through images of us.

### Tempo

Tempo will provide a quick message interface to send messages to the other's watch.

Messages will include:

- I love you~
- I miss you
- Be safe!
- Tempo
- Check Phone!
- Call?
- I want you 🥴🥴

### ISeeYou

ISeeYou will provide several monitoring features for the partner such as:

- Location Tracking
- Heart Rate Monitoring

## Server
There will also be a server written using FastAPI to facilitate the watches communicating with each other, and accessing data from the other.
The server will provide services that can be used by each of the watches' applications.

### Tempo
The routes for the Tempo application will use websockets.
Once the connection is established, messages will consist of an integer, which will be used to index an array of messages to display.

WS: /ws/tempo/ - Establish a websocket connection with the mobile application.

## Mobile

To allow for more advanced communications for the watches, a mobile application will be developed using Flutter.
This will provide greater flexibilty, and allow the usage of tools such as websockets, amongst other things, then pass the information over to the watch via bluetooth.

The mobile application will have access to all of the watch applications, and will primarily be responsible for sending and receiving data to / from the server, from / to the watches, acting as a mediator for the watch, to the outside world.

More information will be present in the ./mobile/README.md file.

