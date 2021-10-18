//@x -> x coordinate of missile
//@y -> y coordinate of missile
class Gravity {
	var x;
	var y;

	function initialize() {
		x = 0;
		y = 0;
	}

	function setY(value) { y = value; }
	function setX(value) { x = value; }
}