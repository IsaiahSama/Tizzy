let currentMessage = null;

const displayTempo = (data) => {
    let newMessage = data.message;
    currentMessage = newMessage;

    Bangle.buzz(1000);

};

const drawTempo = () => {
    let w = g.getWidth();
    let h = g.getHeight();

    let x = w / 2;
    let y = h / 2;

    let message = currentMessage ?? "???";

    // g.reset();
    // g.setFont("Vector", 23).setFontAlign(0, 0);
    // g.drawString(message, x, y);

    E.showMessage(message, "Tizzy");
};

const draw = () => {
    // Draw based on current state
    g.clearRect(Bangle.appRect);
    drawTempo();
};

g.clear(1);

setInterval(draw, 1000);

Bangle.loadWidgets();
Bangle.drawWidgets();