//@x -> x coordinate of missile
//@y -> y coordinate of missile
class Gravity {
	var x;
	var y;
	var rotation;
	var speed;

	function radians(degrees) { return degrees * (3.146) / 180; }
	
	function initialize() {
		x = 0;
		y = 0;
		speed = 0;
		rotation = 270;
	}
	
	function getNextCoordinate() {
		x = speed * Math.sin(radians(rotation));
		y = speed * Math.cos(radians(rotation));
	}

	function setY(value) { y = value; }
	function setX(value) { x = value; }
}