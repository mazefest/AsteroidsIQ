using Toybox.Graphics;

class AsteroidMaker {
	var level;
	var asteroids = [];

	enum {Easy, Medium, Hard}

	function levelAsteroidCount() {
		if (level == Easy) {
			return 1;
		} else if (level == Medium) {
			return 3;
		} else if (level == Hard) {
			return 5;
		}
	}

	function initialize() {
		level = Medium;
		generateNewAsteroid();
	}

	function checkForLostAsteroid() {
		// lost asteroids are too far away and need to be removed.COLOR_TRANSPARENT
		for (var i = 0; i < asteroids.size(); i++) {
			var asteroid = asteroids[i];
			if (asteroid != null) {
			var x = asteroid.x;
			var y = asteroid.y;
			if (x > 300 || x < -40) {
				removeAsteroid(asteroid);
			} 

			if (y > 300 || y < -40) {
			
				removeAsteroid(asteroid);
			}
			}
		}
	}

	function removeAsteroid(asteroid) {
		asteroids.remove(asteroid);
		generateNewAsteroid();
	}

	function generateNewAsteroid() {

		for (var i = asteroids.size(); i < levelAsteroidCount(); i++) {
			var r = generateRandomDegree();
			var points 	= generateRandomAsteroidLocation(r);
			var x = points[0];
			var y = points[1];
			var speed  = 0;
			var size 	= generateRandomAsteroidSize();
			var degrees = 0;
			var newAsteroid = new Asteroid(x, y, speed, size, r);
			newAsteroid.color = Graphics.COLOR_RED;
			asteroids.add(newAsteroid);
		}

	}

	function generateRandomAsteroidSize() {
		return Math.rand() % 3;
	}

	function generateRandomAsteroidLocation(degree) {
		var randomRotation = adjustWithDegree(degree, 270);
		var length = 120;
		var newX = length*Math.cos(Util.radians(randomRotation)) + 120;
		var newY = length*Math.sin(Util.radians(randomRotation)) + 120;
		return [newX, newY];
	}
	function generateRandomDegree() {
		return Math.rand() % 360;
	}

	function flipDegree(degree) {
		var flipped = degree - 180;
		if (flipped < 0) {flipped = 360 - flipped;}
		return flipped;
	}

	function adjustWithDegree(value, adjustment) {
		var newValue = value - adjustment;
		if (newValue < 0) {newValue = newValue*-1;}
		return newValue;
	}
	function generateRandomAsteroidSpeed() {
		return Math.rand() % 3;
	}

	function drawAsteroids(dc) {
		for (var i = 0; i < asteroids.size(); i++) {
			if (asteroids[i] == null) {
				print("is null");
			} else {
				asteroids[i].draw(dc);
			}
		}
	}

	function incrementLevel() {
		level = (level + 1) % Hard;
	}

	function breakUpAsteroid(missile, asteroid) {

	}

	function collision(missile) {
		var newAsteroidFragment1 = null;
		var newAsteroidFragment2 = null;
		for (var i = 0; i < asteroids.size(); i++) {

			var collided = asteroids[i].collision(missile);
			if (collided) {
				if (asteroids[i].size == 2) {
					var d = asteroids[i].gravity.direction;
					var y = asteroids[i].y;
				
					newAsteroidFragment1 = new Asteroid(asteroids[i].x, y, 1, 1, d);
					newAsteroidFragment2 = new Asteroid(asteroids[i].x, y + newAsteroidFragment1.radius(), 1, 1, d);

					newAsteroidFragment1.rotate(45);
					newAsteroidFragment2.rotate(-45);

					removeAsteroid(asteroids[i]); 
				} else if (asteroids[i].size == 1) {
					asteroids[i].size = 0;
				} else {
					removeAsteroid(asteroids[i]); 
				}
				if (newAsteroidFragment1 != null) {
					asteroids.add(newAsteroidFragment1);
					asteroids.add(newAsteroidFragment2);
				}

				return true;
			}
		}
		return false;
	}
}