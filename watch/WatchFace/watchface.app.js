const Layout = require("Layout");
let drawTimeout;

const start = () => {
	g.clear(1);
	draw();
};

const queueDraw = () => {
	if (drawTimeout)
		clearTimeout(drawTimeout);

	drawTimeout = setTimeout(function () {
		drawTimeout = undefined;
		draw();
	}, 60000 - (Date.now() % 60000));
};

const clockLayout = new Layout({
	type: "v", c: [
		{ type: "txt", font: "Vector:50", label: "12:00 XX", id: "time" },
		{ type: "txt", font: "6x8:2", label: "XXX XX XXXX", id: "date" },
		{ type: "txt", font: "6x8:3", label: "XXXXXXXXX", id: "dow" }
	]
}, { lazy: true });

clockLayout.update();

const drawClock = (w, h) => {
	let x = w / 2;
	let y = h * 0.4;

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
	g.setBgColor(0, 0, 0);

	clockLayout.render();

};

const draw = () => {
	// Setting up state

	let w = g.getWidth();
	let h = g.getHeight();

	drawClock(w, h);

	queueDraw();
};

start();

Bangle.setUI("clock");

Bangle.loadWidgets();
Bangle.drawWidgets();
