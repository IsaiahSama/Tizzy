const Layout = require("Layout");

const STATES = {
    DISPLAY: "display",
    SEND: "send",
};

let validStates = ["display", "send"];

let currentState = null;
let currentMessage = null;

const changeState = (newState) => {
    if (!validStates.includes(newState)) {
        Terminal.println("Invalid state!");
        return;
    }
    currentState = newState;
};

const displayTempo = (data) => {
    let newMessage = data.message;
    currentMessage = newMessage;

    changeState(STATES.DISPLAY);
};

const drawDisplayState = () => {
    let w = g.getWidth();
    let h = g.getHeight();

    let x = w / 2;
    let y = h / 2;

    g.setFont("Vector", 23).setFontAlign(0, 0);

    let message = currentMessage ?? "???";

    g.drawString(message, x, y);
};

const sayHello = () => {
    let json = {
        t: "intent",
        package: "com.example.tizzy_watch",
        target: "activity",
        action: "android.intent.action.PROCESS_TEXT",
        flags: ["FLAG_ACTIVITY_NEW_TASK"],
        extra: { "android.intent.action.PROCESS_TEXT": "Hello From Bangle!" }
    };

    Bluetooth.println(JSON.stringify(json));
};

let sendStateLayout = new Layout({
    type: "btn", font: "6x8:2", label: "Hello Phone!", cb: sayHello, id: "sendButton"
});

const drawSendState = () => {
    sendStateLayout.render();
};

const draw = () => {
    // Draw based on current state
    g.clearRect(Bangle.appRect);
    g.reset();

    if (currentState == STATES.DISPLAY) {
        drawDisplayState();
    } else if (currentState == STATES.SEND) {
        drawSendState();
    } else {
        g.drawString("Unknown State", 20, 50, 1);
    }
};

g.clear(1);

changeState(STATES.SEND);

setInterval(draw, 1000);

Bangle.loadWidgets();
Bangle.drawWidgets();