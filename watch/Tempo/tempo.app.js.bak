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

    g.reset();

    g.setFont("Vector", 23).setFontAlign(0, 0);

    let message = currentMessage ?? "???";

    g.drawString(message, x, y);
};

const draw = () => {
    // Draw based on current state
    g.clearRect(Bangle.appRect);

    if (currentState == STATES.DISPLAY) {
        drawDisplayState();
    } else {
        g.drawString("Not Display State", 20, 50, 1);
    }
};

g.clear(1);

changeState(STATES.SEND);

setInterval(draw, 1000);

Bangle.loadWidgets();
Bangle.drawWidgets();