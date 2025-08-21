# Tizzy

Ready to get Tizzy? 🥰

Tizzy is a combination of applications representing a full, customizable experience for busy couples, friends or the like. (Currently, designed to work for pairs, and works even better with developers!).

Tizzy consists of a mobile application, a web server, and a custom watch application for the [Bangle JS 2](https://www.espruino.com/Bangle.js2).

(Bangle JS is a fully open smartwatch providing support for community owned, and your own custom applications written in JavaScript.)

From anywhere in the world as long as you and your pair have internet, you can send subtle vibrations to their watch along with custom messages! Great for keeping in touch and staying connected without needing to always be checking the phone.

Note:

As mentioned, Tizzy is broken up into three components, however only two of them (mobile app and webserver) are required. The third one (the Bangle JS) is optional, and can technically be replaced with any self-programmable device (making use of the `watch/tizzy.app.js` file as reference), however the Bangle JS will provide a consistent experience as that is what I would have used in my testing.

## Using the Service

Note: Currently, only the webserver is hosted and readily available. The code for the mobile application is provided (developed in flutter), and will need to be built by the consumer and installed on your device `flutter run` or equivalent. The software for the watch is provided in the `/watch/tizzy.app.js` file, alongside the `tizzy.info` file, both of which should be placed on the watch using the upload feature of the [Espruino IDE](https://www.espruino.com/ide/#).


The core service can be setup simply in one step.

1. Build and install the [Tizzy Mobile Application](./mobile/tizzy_watch/) on you, and your partner's phones.

The mobile application by default, will point to the [Tizzy webserver](https://tizzy.onrender.com), providing functionality.

After installing the application, you will be prompted to "register" your device. 

The first person will select "Get Started", which will generate a unique ID for their phone. Once in the app, the first person will go to "Profile" from the side menu, copy and share their ID with their partner. 

The partner can then enter the `companion ID` where prompted, then select "Get Started". 

The two devices are now paired together, and ready for communicating!
Try it out by going to `TizzChat` or `Tempo` and sending a message. The other's phone should receive and display the notification!

From here, we can optionally take it two steps further.

The most unique aspect of this service, is the Bangle.js2 watch, which can be programmed to create unique experiences, and is even fairly beginner friendly (super beginner friendly if you also use AI)!

Once you have obtained a Bangle JS, there's a few steps that needs to be done:

1. Pair your watch to your phone or laptop via bluetooth, and visit the [Bangle JS App Loader](https://banglejs.com/apps/). From here, press the `Connect` button to connect your watch to the App Loader.
1. Ensure the firmware is up to date (following instructions provided). (Can also explore the library for anything you may find intereseting.)
1. Ideally, from a laptop or computer, visit the [Espruino Web IDE](https://www.espruino.com/ide/#).
1. Press the socket button in the top left, and connect your watch to the ide.
1. Press the icon that says "Access files in device's storage", and add the `/watch/tizzy.app.js` and `/watch/tizzy.info` files.
1. Connect the watch to your phone.
1. Install [Gadgetbridge](https://www.espruino.com/Gadgetbridge) on your phone. This is used to facilitate communication between your watch and your phone (primarily used for receiving messages). This link also provides some setup information.
1. Open Gadgetbridge, grant it permissions, and then "Add new device", adding your bangle JS.
1. Once connected, press the settings icon on the connected device option in Gadgetbridge, then:
    - Enable "Allow Internet Access"
    - Enable "Allow Intents"
    - Optionally disable "Send Notifications". (This refers to notifications like WhatsApp messages etc showing on the watch.)
1. Final step. Open Tizzy_Watch mobile application, and press the 🔃 icon in the top right. This connects the app to your watch.

That's it! Your watch is now setup and ready for Tizzying.
Try opening the Tizzy app from the Bangle Menu, and then tapping the clock face, then selecting a message!

The final optional step, is to host the server yourself!
All of the code is provided in the `/server` folder, ready for you to deploy.

Note: If you want to send messages from the watch directly, your hosted server must be `https`. As for why, you can read [this section](https://www.espruino.com/Gadgetbridge#http-requests)

## How it Works

### Mobile Application

The mobile application Tizzy_Watch is an android app developed for and tested on Android (for now). It acts as a central hub for the service, providing communication with the server (and by extension your other half), along with the Bangle JS Watch, passing on received messages from your partner, and causing the watch to "buzz" / vibrate accordingly.

For the technical details and an overview of all features, refer to [this README](./mobile/README.md).

### Server

This is a simple python web server, designed to facilitate communication between the two paired devices. The server is responsible for the logic involving pairing two devices, facilitating messaging, and any future features.

While there is a hosted version at [Tizzy](https://tizzy.onrender.com), you may feel free to host the server on any platform you choose. Note, the hosted version is hosted for free, and as such may have a wait time of up to 50 seconds every hour. When hosting the server yourself, if you are making use of a Bangle JS, then ensure the server is hosted using `https` instead of just `http`.

### Bangle JS 2

The Bangle JS 2 is self-programmable watch sold by [Espruino](https://www.espruino.com/Bangle.js2), and as such supports custom programming using JavaScript.

For Tizzy, the script provided in [tizzy.app.js](./watch/tizzy.app.js) provides a custom watchface, and support for sending messages to your partner, and receiving them and vibrating accordingly.