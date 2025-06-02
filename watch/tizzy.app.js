const Layout = require("Layout");
let drawTimeout;
let currentMessage;

const STATES = {
	WATCH: "watch",
	TEMPO: "tempo",
};

let currentState = STATES.WATCH;
let currentStateIndex = 0;

let validStates = ["watch", "tempo"];

// utils
const changeState = (newState) => {
	if (!validStates.includes(newState)) {
		Terminal.println("Invalid state!");
		return;
	}
	currentState = newState;
	drawTimeout = null;
	draw();
};

const handleDrag = (event) => {
	if (event.b != 0) {
		return;
	}

	// Change to the next subsequent state
	currentStateIndex = (currentStateIndex + 1) % validStates.length;
	changeState(validStates[currentStateIndex]);
};

const queueDraw = (delay) => {
	if (drawTimeout)
		clearTimeout(drawTimeout);

	drawTimeout = setTimeout(function () {
		drawTimeout = undefined;
		draw();
	}, delay);
};

// Watch Draw

const drawWatch = () => {
	let clockLayout = new Layout({
		type: "v", c: [
			{ type: "txt", font: "Vector:50", label: "12:00 XX", id: "time" },
			{ type: "txt", font: "6x8:2", label: "XXX XX XXXX", id: "date" },
			{ type: "txt", font: "6x8:3", label: "XXXXXXXXX", id: "dow" }
		]
	}, { lazy: true });
	clockLayout.update();

	let d = new Date();
	let clock = require("locale").time(d, 1);
	let meridian = require("locale").meridian(d);
	let time = clock + " " + meridian;

	let date = require("locale").date(d);
	let day = require("locale").dow(d);

	clockLayout.time.label = time;
	clockLayout.date.label = date;
	clockLayout.dow.label = day;

	// Preparing to draw
	clockLayout.render();
};

// Tempo Draw

const displayTempo = (data) => { // Function called from Phone

	let newMessage = data.message;
	currentMessage = newMessage;
    Bangle.buzz(1000);

	changeState(STATES.TEMPO);
	setTimeout(() => {
		changeState(STATES.WATCH);
	}, 5000);
	draw(); // Trigger draw
};

const drawTempo = () => {
	let message = currentMessage ?? "???";
	const tempoLayout = new Layout(
		{
			type: "txt", font: "Vector:24", label: message, id: "tempo"
		}
	);

	tempoLayout.update();

	tempoLayout.render();
};

// Global Draw

const draw = () => {
	// Draw based on current state
	let drawDelay = 1000;
	g.clearRect(Bangle.appRect);
	if (currentState === STATES.WATCH) {
		drawWatch();
		drawDelay = 60000 - (Date.now() % 60000);
	} else if (currentState === STATES.TEMPO) {
		drawTempo();
	}

	queueDraw(drawDelay);
};

Bangle.on("drag", handleDrag);

draw();

Bangle.setUI("clock");

Bangle.loadWidgets();
Bangle.drawWidgets();
