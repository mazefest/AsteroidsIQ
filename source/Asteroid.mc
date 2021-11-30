
using Toybox.Graphics;
using Toybox.Math;

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
		color = Graphics.COLOR_BLUE;
		//computeStartingPoint();
	}

	function draw(dc) {
		gravity.apply(self);
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