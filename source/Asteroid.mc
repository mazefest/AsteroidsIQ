
using Toybox.Graphics;
using Toybox.Math;

class Point {
	var x;
	var y;

	function initialize(x,y) {
		self.x = x;
		self.y = y;
	}
}

class Asteroid {
	enum {Small, Medium, Large}
	var x;
	var y;
	var size;
	var speed;
	var gravity;
	var color;
	
	function initialize(x, y, speed, size, direction) {
		self.x = x;
		self.y = y;
		self.size = size;
		gravity = new Gravity();
		gravity.direction = direction;
		color = Graphics.COLOR_WHITE;
		//computeStartingPoint();
	}

	function draw(dc) {
		gravity.apply(self);
		dc.setPenWidth(1);
		dc.setColor(color, Graphics.COLOR_TRANSPARENT);
		dc.drawCircle(x, y, self.radius());
	}

	function radius() {
		switch(size) {
			case Small:
				return 10;
			case Medium:
				return 20;
			case Large:
				return 30;
			default:
				return 20;

		}
	}

	// Returns true if `Ship` has a point that lies inside of the circle
	function shipCollision(ship) {
		// a ship has 3 points, chekc if any of the points are inside the circle
		for(var i = 0; i < ship.pointMap.size(); i++) {
			var shipPointArr = ship.points[i];

			// init points
			var shipPoint = new Point(shipPointArr[0], shipPointArr[1]);
			var asteroidPoint = new Point(x, y);

			var distanceBetweenPoints = Util.distanceBetween(shipPoint, asteroidPoint);

			if (distanceBetweenPoints <= radius()) {
				return true; // collision
			}
		}
		return false;
	}

	function collision(missile) {
		var a = Math.pow(missile.x - x, 2);
		var b = Math.pow(missile.y - y, 2);
		var c = a + b;
		var x =Math.pow(radius() , 2);
		var collided = (c <= Math.pow(radius(), 2));

		return collided;
	}

	function rotate(degrees) {
		gravity.rotate(degrees);
	}
}