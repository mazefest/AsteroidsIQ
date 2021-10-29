
class Asteroid {
	var x;
	var y;
	var direction;
	var size;
	var speed;
	var gravity;
	function initialize() {
		gravity = new Gravity();
		gravity.direction = 225;
		computeStartingPoint();
	}

	function computeStartingPoint() {
		// right now all asteroids will come from bottom right corner
		x = 240;
		y = 240;
	}

	function draw(dc) {
		gravity.apply(self);
		dc.drawCircle(x, y, 30);
	}
}

// class AsteroidSpeed() {
// 	enum {Slow, Medium, Fast}
// 	var speed;
// 	function initalize() {
// 		speed = Medium;
// 	}

// 	function getSpeed() {

// 	}
// }


// class AsteroidSize() {
// 	enum {Small, Medium, Large}
// 	var size;	
// 	function initialize() {
// 		size = Medium;
// 	}

// 	function radius() {
// 		if (size == Small) {
// 			return 15;
// 		} else if (size == Medium) {
// 			return 20;
// 		} else if (size == Large) {
// 			return 30;
// 		}
// 	}
// }