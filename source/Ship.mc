using Toybox.WatchUi;
using Toybox.Timer;
using Toybox.Graphics;
using Toybox.Lang;
using Toybox.Math;
using Toybox.System;

//@x: Int -> x coordinate of ship
//@y: Int -> y coordinate of ship
//@width: Int -> pen width used to draw ship
//@color: Graphics.COLOR -> color of the ship
//@rotation: int -> used to draw the ship rotation
//@speeds: [int] -> used to determine the advance speed of the ship
//@speedsIndex: Int -> index used for speeds
//@gravity: Gravity -> used to implement gravity/momentum of ship
//@flames: Flames -> Used to draw flames at the back of the ship

class Ship {
	// center x,y
	var x;
	var y;
	var points;
	var width = 4;
	var color = Graphics.COLOR_BLACK;
	var rotation = 270; // degrees
	var speeds = [1,3,5];
	var speedIndex = 0;
	var gravity;
	var flames;
	var pointMap = [[5, -5], [-5, -5], [0, 10]]; // this is the map for the ship

	function initialize() {
		x = 120;
		y = 120;

		var pointLeft = [x + 5, y - 5];
		var pointRight = [x - 5, y - 5];
		var pointFace = [x - 5, y + 10];
		points = Util.rotatePoints([x,y], pointMap, rotation);

		flames = new Flames();
		gravity = new Gravity();
	}

	function speed() { return speeds[speedIndex]; }

	function updatePoints() {
		var pointLeft = [x + 5, y - 5];
		var pointRight = [x - 5, y - 5];
		var pointFace = [x - 5, y + 10];
		var pts = Util.rotatePoints([x,y], pointMap, rotation);
		points = pts;
	}

	function draw(dc) {
		applyGravity();
		updatePoints();

		//update
		// var pointLeft = [x + 5, y - 5];
		// var pointRight = [x - 5, y - 5];
		// var pointFace = [x - 5, y + 10];
		// var pts = Util.rotatePoints([x,y], pointMap, rotation);

		dc.setPenWidth(1);
		dc.fillPolygon(points);

		flames.draw(dc, x, y, rotation);
	}

	function rotateCounterClockWise() {
		rotation = (rotation - 20) >= 0 ? rotation - 20 : 359;
		System.println(rotation);
	}
	function rotateClockWise() {
		rotation = (rotation + 20) % 360;
	}

	function gas() {
		gravity.forceFrom(rotation);
		flames.activate();
	}

	function getNextCoordinate() {
		var y = speed() * Math.cos(Util.radians(rotation));
		var x = speed() * Math.sin(Util.radians(rotation));
		return [x,y];
	}

	function applyGravity() {
		gravity.getNextCoordinate();
		x += gravity.x;
		y += gravity.y;
	}

	function shiftSpeed() {
		gas();
	}
}

function print(string) {
	System.println(string);
}
