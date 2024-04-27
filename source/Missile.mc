using Toybox.Math;

//@x -> x coordinate of missile
//@y -> y coordinate of missile
//@rotation -> rotation to draw missile in degrees 
class Missile {
	var x;
	var y;
	var rotation;
	
	function initialize(x,y, rotation) {
		self.x = x;
		self.y = y;
		self.rotation = rotation;
	}
	
	function radians(degrees) { return degrees * (3.146) / 180; }

	function draw(dc) {
		var a = getNextCoordinate();
		x += a[0];
		y += a[1];
		dc.setPenWidth(2);
		dc.drawPoint(x, y);
	}

	function getNextCoordinate() {
		var speed = 10;
		var y = speed * Math.cos(radians(rotation));
		var x = speed * Math.sin(radians(rotation));
		return [x,y];
	}
}