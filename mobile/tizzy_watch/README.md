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

## Routing

Tizzy will have the following screens and their corresponding routes.

- Home: /
- Tempo: /tempo
- ISeeYou: /iseeyou
- TizzChat: /tizzchat

These will represent the routes that will display each of their related screens.


