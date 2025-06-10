let Layout = require("Layout");
let userID = null;

const STATES = {
	WATCH: "watch",
	TEMPO: "tempo",
};

const PATHS = {
	BASE: "https://tizzy.onrender.com",
	TEMPO: "/tempo/w/notify",
};

let drawTimeout;
let currentMessage;

let currentState = STATES.WATCH;

let validStates = ["watch", "tempo"];

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

function trigger() {
	Bangle.http(PATHS.BASE);
}

function sendTempoMessage(message) {
	// perform some action to send message.
	// This will either be HTTP to server directly.
	// Or intent to Phone to send to server.
	if (!userID) {
		Bangle.buzz(100).then(() => setTimeout(() => Bangle.buzz(100), 100));
		return;
	}
	let payload = {
		message,
		"sender_id": userID,
	};

	options = {
		method: "post",
		body: payload,
		timeout: 52 * 1000, // 52 seconds
		headers: {
			"Content-Type": "application/json"
		}
	};

	Bangle.http(PATHS.BASE + PATHS.TEMPO, options).then(data => {
		Bangle.buzz(500);
	});

}

function closeMenu() {
	if (isMenu == false) return;
	isMenu = false;
	changeState(STATES.WATCH);
	Bangle.setUI("clock");
}

let messageMenu = {
	"": {
		title: "Tempo Menu",
		back: closeMenu
	},
	"Tempo": () => sendTempoMessage("Tempo"),
	"I love you!": () => sendTempoMessage("I love you!"),
	"I love you too!": () => sendTempoMessage("I love you too!"),
	"I miss you!": () => sendTempoMessage("I miss you!"),
	"Me too!": () => sendTempoMessage("Me too!"),
	"You too!": () => sendTempoMessage("You too!"),
	"Checking In!": () => sendTempoMessage("Checking In!"),
	"Stay Safe!": () => sendTempoMessage("Stay Safe!"),
	"Thankie": () => sendTempoMessage("Thankie"),
	"Yw": () => sendTempoMessage("Yw"),
	"I'm okay!": () => sendTempoMessage("I'm okay!"),
	"I'm sad!": () => sendTempoMessage("I'm sad!"),
	"I'm here!": () => sendTempoMessage("I'm here!"),
	"I'm Busy!": () => sendTempoMessage("I'm Busy!"),
	"MWAH!": () => sendTempoMessage("MWAH!"),
	"Yes!": () => sendTempoMessage("Yes!"),
	"No!": () => sendTempoMessage("No!"),
	"No you!": () => sendTempoMessage("No you!"),
	"Hungy...": () => sendTempoMessage("Hungy..."),
	"NOMS!": () => sendTempoMessage("NOMS!"),
	"Call me": () => sendTempoMessage("Call me"),
	"Buzz buzz": () => sendTempoMessage("Buzz buzz"),
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
			{ type: "txt", font: "6x8", label: userID == null ? "Not synced with Phone" : "Synced with Phone", id: "userID" }
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

// Android -> Bangle JS
let tempoTimeout = null;
let countTimeout = null;
let counter = 0;
function displayTempo(data) { // Function called from Phone

	let newMessage = data.message;
	closeMenu();

	function doTempo(message) {
		currentMessage = message;
		Bangle.buzz(counter < 2 ? 1000 : 200);
		Bangle.setBacklight(1);
		changeState(STATES.TEMPO);

		tempoTimeout = setTimeout(() => {
			changeState(STATES.WATCH);
		}, 5000);
	}

	counter += 1;

	if (tempoTimeout) {
		clearTimeout(tempoTimeout);
		setTimeout(() => doTempo(newMessage), 1200 * counter);
	}
	else {
		doTempo(newMessage);
	}
	if (countTimeout) {
		clearInterval(countTimeout);
	}

	countTimeout = setTimeout(() => counter = 0, 5000);
}

function setUserID(data) {
	userID = data.userID;
	draw();
}

// Tempo Draw

function drawTempo() {
	let message = currentMessage ?? "???";
	const tempoLayout = new Layout(
		{
			type: "txt", font: "Vector:22", label: message, id: "tempo"
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

Bangle.on('touch', function (b, xy) {

	if (currentState == STATES.WATCH && !isMenu) {
		trigger();
		isMenu = true; // Set flag that menu is open
		clearTimeout(drawTimeout); // Stop the clock drawing loop
		E.showMenu(messageMenu);
	}
});

Bangle.loadWidgets();
changeState(STATES.WATCH);
Bangle.drawWidgets();

Bangle.setUI("clock");