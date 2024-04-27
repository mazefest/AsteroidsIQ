using Toybox.WatchUi;
using Toybox.Timer;
using Toybox.Graphics;
using Toybox.Lang;
using Toybox.Math;

enum GameState {home, active, gameOver}

class Space extends WatchUi.View {
	var timer;
	var ship;
	var missiles;
	var asteroidManager;
	var timeOutCount = 0;
	var width;
	var height;
	var info;

	var isActive;

	var gameState;

	function initialize() {
		View.initialize();
		timer = new Timer.Timer();
		timer.start(new Lang.Method(self, :driver), 100, true);
		ship = new Ship();	

		missiles = [];

		asteroidManager = new AsteroidMaker();	
		info = new InfoBar();

		isActive = false;

		gameState = home;
	}

	function reset() {
		ship = new Ship();	

		missiles = [];

		asteroidManager = new AsteroidMaker();	
		info = new InfoBar();

		isActive = true;
	}

	function onLayout(dc) {
		width = dc.getWidth();
		height = dc.getHeight();
	}

	function onUpdate(dc) {
		View.onUpdate(dc);

		switch(gameState) {
			case home:
				drawHomeView(dc);
				break;
			case active:
				drawActiveGame(dc);
				break;
			case gameOver:
				drawGameOverView(dc);
				break;
		}

	}

	function drawGameOverView(dc) {
			var dataStore = new DataStore();
			var highScore = dataStore.getHighScore(); 

			if (info.score > highScore) {
				dataStore.setHighScore(info.score);
				dc.drawText(120, 60, Graphics.FONT_SYSTEM_MEDIUM, "New High Score!", Graphics.TEXT_JUSTIFY_CENTER);
				dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_BLACK);
				dc.drawText(120, 90, Graphics.FONT_SYSTEM_MEDIUM, info.score, Graphics.TEXT_JUSTIFY_CENTER);
			}

			dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
			dc.drawText(120, 120, Graphics.FONT_SYSTEM_MEDIUM, "Game Over", Graphics.TEXT_JUSTIFY_CENTER);


	}

	function drawActiveGame(dc) {
			dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);

			checkShipLocation();

			ship.draw(dc); // draw ship
			drawMissiles(dc); // draw missiles
			asteroidManager.drawAsteroids(dc); // draw asteroids

			// collisions
			checkForShipAsteroidCollision();
			info.draw(dc);
	}

	function drawHomeView(dc) {
		var dataStore = new DataStore();
		var highScore = dataStore.getHighScore(); 

		dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
		dc.drawText(120, 60, Graphics.FONT_SYSTEM_MEDIUM, "High Score:", Graphics.TEXT_JUSTIFY_CENTER);
		dc.drawText(120, 90, Graphics.FONT_SYSTEM_MEDIUM, highScore, Graphics.TEXT_JUSTIFY_CENTER);
		dc.drawText(120, 120, Graphics.FONT_SYSTEM_MEDIUM, "Start Buton To Start", Graphics.TEXT_JUSTIFY_CENTER);
		asteroidManager.drawAsteroids(dc); // draw asteroids
	}


	function drawMissiles(dc) {
		for (var i = 0; i < missiles.size(); i++) {
			missiles[i].draw(dc);
		}
	}

	function checkForMissileAsteroidCollisions() {
		for (var i = 0; i < missiles.size(); i++) {
			var missile = missiles[i];
			if (asteroidManager.collision(missile)) {
				missiles.remove(missiles[i]);
				info.addScore(10);	
			}
		}
	}

	function checkForShipAsteroidCollision() {
		if (asteroidManager.shipCollision(ship)) {
			self.gameState = gameOver;
			//self.isActive = false;
			//timer.stop();
		}
	}

	function driver() {
		timeOutCount += 1;
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
