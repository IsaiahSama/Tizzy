# Tizzy (Mobile Application)
Tizzy will serve as a mediator between the Banglejs watches, and the server, primarily with the following roles:

- Sending health data to the server, and back.
- Facilitating the use of Tempo.

Tizzy (Mobile Application) will be developed using Flutter, primarily for the android device.

The app will have a list of menu options, corresponding to the apps on the watch that it supports.
Communication between the watches, and the apps will be done using intents as laid out [here](https://www.espruino.com/Gadgetbridge).

The apps that will be supported are:

- Tempo
- ISeeYou

Tizzy will also provide access to a simple chat interface called TizzChat.

The wireframe for this project is located in the `wireframe.png` image located in this folder.

## Routing

Tizzy will have the following screens and their corresponding routes.

- Home: /
- Tempo: /tempo
- ISeeYou: /iseeyou
- TizzChat: /tizzchat

These will represent the routes that will display each of their related screens.

## Bangle Communication

The primary feature of this application is to facilitate communication between the BangleJS, and the mobile application, and by extension, allow it to share information to the partner's BangleJS through this mobile application on their phone.

Primarily, this will be done in the form of sending messages from the flutter application over to the Bangle JS, by way of android intents, using GadgetBridge as an intemediary.

The `GadgetBridgeService`, as it is appropriately called, will facilitate communication between the flutter application and the BangleJS, in a one-directional manner (will be upgraded to be bi-directional once it is better understood). 

This service will provide a method, to simplify calling specific functions from the flutter code.

The primary static method of the `GadgetBridgeService`, will be the `sendToBangle`, which has the following signature:

```dart
static Future<void> sendToBangle(String, Map<String, dynamic>) async {}
```

Where the `String` will be the name of the BangleJS function to call as defined in the `watch/tizzy.app.js` file, and the `Map<String, dynamic>`, will be the data to be sent to the BangleJS, to be used as arguments for the previously provided function name. This data will be json encoded inside of this function before being transmitted to the watch.

GadgetBridgeService will also provide additional wrapper methods to simplify calling `sendToBangle` for specific use cases. For example:

```dart
static Future<void> sendTempoMesssage(TempoMessage) async {}
```

This method accepts a custom defined TempoMessage object, which it will the turn into an appropriately formatted `Map<String, dynamic>`, then call `sendToBangle` with the correct function name, and formatted data arguments.


