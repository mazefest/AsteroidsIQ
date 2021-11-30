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

class InfoBar {
	var lives;
	var level;
	var score;

	function initialize() {
		lives = 3;
		level = 1;
		score = 0;
		
	}

	function draw(dc) {
		dc.fillRectangle(0, 200, 300, 100);
		drawScore(dc);
	}

	function drawScore(dc) {
		dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
		dc.drawText(120, 205, Graphics.FONT_XTINY, "Score: " + score.toString(), Graphics.TEXT_JUSTIFY_LEFT);
	}

	function addScore(value) {
		score += value;
	}
}

class Space extends WatchUi.View {
	var timer;
	var ship;
	var missiles = [];
	var asteroidManager;
	var timeOutCount = 0;
	var width;
	var height;
	var info;
	function initialize() {
		View.initialize();
		timer = new Timer.Timer();
		timer.start(new Lang.Method(self, :driver), 100, true);
		ship = new Ship();	

		asteroidManager = new AsteroidMaker();	
		info = new InfoBar();
	}

	function onLayout(dc) {
		width = dc.getWidth();
		height = dc.getHeight();
	}

	function onUpdate(dc) {
		View.onUpdate(dc);
		dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_WHITE);
		dc.clear();
		dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_WHITE);
		ship.draw(dc);
		checkShipLocation();
		drawMissiles(dc);
		asteroidManager.drawAsteroids(dc);
		info.draw(dc);
	}


	function drawMissiles(dc) {
		for (var i = 0; i < missiles.size(); i++) {
			missiles[i].draw(dc);
		}
	}

	function checkForMissileAsteroidCollisions() {
		System.println("Missile Count: " + missiles.size());
		for (var i = 0; i < missiles.size(); i++) {
			var missile = missiles[i];
			if (asteroidManager.collision(missile)) {
				missiles.remove(missiles[i]);
				info.addScore(10);	
			}
		
		}

	}

	function driver() {
		timeOutCount += 1;
		if (timeOutCount >= 600) {System.exit();}
		WatchUi.requestUpdate();
		asteroidManager.checkForLostAsteroid();
		checkForMissileAsteroidCollisions();
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




