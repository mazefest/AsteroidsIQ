using Toybox.WatchUi;
using Toybox.Timer;
using Toybox.Graphics;
using Toybox.Lang;
using Toybox.Math;

function startGame() {
	var view = new Space();
	var delegate = new SpaceDelegate(view);
	var transition = WatchUi.SLIDE_IMMEDIATE;
	WatchUi.pushView(view, delegate, transition);
}

class Space extends WatchUi.View {
	var timer;
	var ship;
	var missiles = [];
	var timeOutCount = 0;
	function initialize() {
		View.initialize();
		timer = new Timer.Timer();
		timer.start(new Lang.Method(self, :driver), 100, true);
		ship = new Ship();	

	}

	function onUpdate(dc) {
		View.onUpdate(dc);
		dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_WHITE);
		dc.clear();
		dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_WHITE);
		ship.draw(dc);
		for (var i = 0; i < missiles.size(); i++) {
			missiles[i].draw(dc);
		}
	}

	function driver() {
		timeOutCount += 1;
		if (timeOutCount >= 600) {System.exit();}
		WatchUi.requestUpdate();
	}

	function checkShipLocation() {
		if (ship.x < -5) {
			ship.x = width;
		} else if (ship.x > width) {
			ship.x = -5;
		}
		if (ship.y < -5) {
			ship.y = height;
		} else if (ship.y > height) {
			ship.y = -5;
		}
	}

	function drawShip() {

	}

	function clearScreen(dc) {
		dc.clear();
	}

}




