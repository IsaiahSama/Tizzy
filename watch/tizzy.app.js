let Layout = require("Layout");

let drawTimeout;
let currentMessage;

const STATES = {
	WATCH: "watch",
	TEMPO: "tempo",
};

let currentState = STATES.WATCH;
let currentStateIndex = 0;

let validStates = ["watch", "tempo"];

function setUI() {
	Bangle.setUI({
		mode: "custom",
		clock: 1,
		touch: function (n, e) {
			isMenu = true; // Set flag that menu is open
			clearTimeout(drawTimeout); // Stop the clock drawing loop
			E.showMenu(messageMenu);
		},
	});
}

// utils
function changeState(newState) {
	if (!validStates.includes(newState)) {
		Terminal.println("Invalid state!");
		return;
	}
	currentState = newState;

	drawTimeout = null;
	draw();
}

function handleDrag(event) {
	if (event.b != 0) {
		return;
	}

	// Change to the next subsequent state
	currentStateIndex = (currentStateIndex + 1) % validStates.length;
	changeState(validStates[currentStateIndex]);
}

function sendTempoMessage(message) {

	// perform some action to send message.
	// This will either be HTTP to server directly.
	// Or intent to Phone to send to server.

}

let messageMenu = {
	"": {
		title: "Tempo Menu",
		back: function () {
			isMenu = false;
			changeState(STATES.WATCH);
			setUI();
		}
	},
	"Tempo": () => sendTempoMessage("Tempo"),
	"I love you!": () => sendTempoMessage("I love you!"),
	"I miss you!": () => sendTempoMessage("I miss you!"),
	"Checking In!": () => sendTempoMessage("Checking In!"),
	"Stay Safe!": () => sendTempoMessage("Stay Safe!"),
	"I'm okay!": () => sendTempoMessage("I'm okay!"),
	"I'm sad!": () => sendTempoMessage("I'm sad!"),
	"I'm Busy!": () => sendTempoMessage("I'm Busy!"),
	"MWAH!": () => sendTempoMessage("MWAH!"),
	"Hungy...": () => sendTempoMessage("Hungy..."),
	"NOMS!": () => sendTempoMessage("NOMS!")
};

function queueDraw(delay) {
	if (drawTimeout)
		clearTimeout(drawTimeout);

	drawTimeout = setTimeout(function () {
		drawTimeout = undefined;
		draw();
	}, delay);
}

// Watch Draw

function drawWatch() {
	let clockLayout = new Layout({
		type: "v", c: [
			{ type: "txt", font: "Vector:50", label: "77:77", id: "time" },
			{ type: "txt", font: "6x8:2", label: "XXX XX XXXX", id: "date" },
			{ type: "txt", font: "6x8:3", label: "XXXXXXXXX", id: "dow" },
		]
	}, { lazy: true });
	clockLayout.update();

	let d = new Date();
	let time = require("locale").time(d, 1);

	let date = require("locale").date(d);
	let day = require("locale").dow(d);

	clockLayout.time.label = time;
	clockLayout.date.label = date;
	clockLayout.dow.label = day;

	// Preparing to draw
	clockLayout.render();
}

// Tempo Draw

function displayTempo(data) { // Function called from Phone

	let newMessage = data.message;
	currentMessage = newMessage;
	Bangle.buzz(1000);

	changeState(STATES.TEMPO);
	setTimeout(() => {
		changeState(STATES.WATCH);
	}, 5000);
	draw(); // Trigger draw
}

function drawTempo() {
	let message = currentMessage ?? "???";
	const tempoLayout = new Layout(
		{
			type: "v", c: [
				{
					type: "txt", font: "Vector:24", label: message, id: "tempo"
				},
				{
					type: "v", c: [
						{ type: "btn", font: "6x8", label: "OK", cb: () => sendTempoMessage("I'm okay!"), fillx: 1, pad: 3 },
						{ type: "btn", font: "6x8", label: "BBILY", cb: () => sendTempoMessage("Busy, but I love you!"), fillx: 1, pad: 2 },
						{ type: "btn", font: "6x8", label: "Mwah", cb: () => sendTempoMessage("MWAH!"), fillx: 1, pad: 3 },
					]
				}
			]
		}
	);

	tempoLayout.update();

	tempoLayout.render();
}

// Global Draw
let isMenu = false;

function draw() {
	// Draw based on current state
	if (isMenu) return;
	let drawDelay = 1000;
	g.clearRect(Bangle.appRect);
	if (currentState === STATES.WATCH) {
		drawWatch();
		drawDelay = 60000 - (Date.now() % 60000);
	} else if (currentState === STATES.TEMPO) {
		drawTempo();
	}

	queueDraw(drawDelay);
}

//Bangle.on("drag", handleDrag);

Bangle.loadWidgets();
changeState(STATES.WATCH);
Bangle.drawWidgets();

setUI();