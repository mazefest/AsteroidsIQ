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

class Ship {
	var x;
	var y;
	var width = 4;
	var color = Graphics.COLOR_BLACK;
	var rotation = 270; // degrees
	var speeds = [1,3,5];
	var speedIndex = 0;
	var gravity;

	function initialize() {
		x = 120;
		y = 120;
		gravity = new Gravity();
	}

	function speed() { return speeds[speedIndex]; }

	function draw(dc) {
		applyGravity();
		var pointLeft = [x + 5, y - 5];
		var pointRight = [x - 5, y - 5];
		var pointFace = [x - 5, y + 10];
		var pts = applyRotation(rotation);
		dc.setPenWidth(width);
		dc.fillPolygon(pts);
	}

	function applyRotation(degrees) {
		var pts = [];
		var points = [[5, -5], [-5, -5], [0, 10]];
		for (var i = 0; i < points.size(); i++) {
			var point = points[i];
			var newY = point[1] * Math.cos(Util.radians(rotation)) - point[0] * Math.sin(Util.radians(rotation)); 
			var newX = point[1] * Math.sin(Util.radians(rotation)) + point[0] * Math.cos(Util.radians(rotation)); 
			newX += x;
			newY += y;
			pts.add([newX, newY]);
		}
		
		return pts;
	}

	function rotateCounterClockWise() {
		rotation = (rotation - 20) >= 0 ? rotation - 20 : 359;
		System.println(rotation);
	}
	function rotateClockWise() {
		rotation = (rotation + 20) % 360;
	}

	function gas() {
		//gravity.speed = 2;
		//`gravity.rotation = rotation;
		gravity.forceFrom(rotation);
		
	}

	function getNextCoordinate() {
		var y = speed() * Math.cos(Util.radians(rotation));
		var x = speed() * Math.sin(Util.radians(rotation));
		return [x,y];
	}

	function applyGravity() {
		gravity.getNextCoordinate();
		//var a = getNextCoordinate();
		x += gravity.x;
		y += gravity.y;
		//x += gravity.x;
		//y += gravity.y;
	}

	function shiftSpeed() {
		gas();
		//speedIndex = (speedIndex + 1) % 3;
	}
}

function print(string) {
	System.println(string);
}
