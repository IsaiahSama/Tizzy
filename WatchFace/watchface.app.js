let drawTimeout;
let clockState = true;

const getImage = () => {
	return require("Storage").read("sample.img");
};


const toggleClockState = () => {
	clockState = !clockState;
	return clockState;
};

const start = () => {
	g.clear(1);

	draw();
};

const queueDraw = () => {
	if (drawTimeout)
		clearTimeout(drawTimeout);

	drawTimeout = setTimeout(function() {
		drawTimeout = undefined;
		draw();
	}, 60000 - (Date.now() % 60000));
};

const handleDrag = (event) => {
	if (event.b != 0) {
		return;
	}

	toggleClockState();
	draw();
};

const drawClock = (w, h) => {
	let x = w / 2;
	let y = h * 0.4;

	let d = new Date();
	let clock = require("locale").time(d, 1);
	let meridian = require("locale").meridian(d);
	let time = clock + " " + meridian;

	let date = require("locale").date(d);
	let day = require("locale").dow(d);

	// Preparing to draw
	g.reset();
	g.setBgColor(0, 0, 0);
	g.clearRect(0, 25, w, h);

	// Drawing time
	g.clearRect(0, y - 25, w, y + 25);
	g.setColor(1, 1, 1);
	g.setFontAlign(0, 0).setFont("Vector", 50);
	g.drawString(time, x + 15, y, true);

	// Drawing Date
	y += 40;
	g.clearRect(0, y - 15, w, y + 15);
	g.setColor(1, 0, 1);
	g.setFontAlign(0, 0).setFont("Vector", 18);
	g.drawString(date, x, y, true);

	// Drawing day of week
	y += 30;
	g.clearRect(0, y - 10, w, y + 10);
	g.setColor(1, 1, 1);
	g.setFontAlign(0, 0).setFont("Vector", 18);
	g.drawString(day, x, y, true);
};

const drawUs = (w, h) => {
	g.clearRect(0, 25, w, h);
	g.reset();
	g.drawImage(getImage(), 0, 24, { scale: 3.8 });
};

const draw = () => {
	// Setting up state

	let w = g.getWidth();
	let h = g.getHeight();

	if (clockState) {
		drawClock(w, h);
	} else {
		drawUs(w, h);
	}

	queueDraw();
};

Bangle.on("drag", handleDrag);

start();

Bangle.setUI("clock");

Bangle.loadWidgets();
Bangle.drawWidgets();
