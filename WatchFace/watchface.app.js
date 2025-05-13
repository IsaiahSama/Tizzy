// require("Font7x11Numeric7Seg").add(Graphics);
let drawTimeout;

const start = () => {
	g.clear(1);

	draw();
}

const queueDraw = () => {
	if (drawTimeout)
		clearTimeout(drawTimeout);

	drawTimeout = setTimeout(function() {
		drawTimeout = undefined;
		draw();
	}, 60000 - (Date.now() % 60000));
}

const draw = () => {
	// Setting up state

	let w = g.getWidth();
	let h = g.getHeight();
	let x = w / 2;
	let y = h * 0.4;

	let d = new Date();
	let clock = require("locale").time(d, 1);
	let meridian = require("locale").meridian(d);
	let time = clock + " " + meridian;

	let date = require("locale").date(d);
	let day = require("locale").dow(d);

	// Preparing to draw

	g.clear(1);

	// Drawing time
	//g.clearRect(0, y - 25, w, y+25);
	//g.setFontAlign(0, 0).setFont("Font7x11Numeric7Seg:4");
	g.setFontAlign(0, 0).setFont("Vector", 60);
	g.drawString(time, x + 20, y);

	// Drawing Date
	y += 40;
	//g.clearRect(0, y -4, w, y + 4);
	g.setFontAlign(0, 0).setFont("Vector", 20);
	g.drawString(date, x, y);

	// Drawing day of week
	y += 30;
	//g.clearRect(0, y - 4, w, y + 4);
	g.setFontAlign(0, 0).setFont("Vector", 17);
	g.drawString(day, x, y);

	queueDraw();
};

start();

Bangle.setUI("clock");

Bangle.loadWidgets();
Bangle.drawWidgets();
