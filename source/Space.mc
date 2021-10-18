using Toybox.WatchUi;
using Toybox.Timer;
using Toybox.Graphics;
using Toybox.Lang;
using Toybox.Math;

function startGame() {
	var view = new Space();
	var delegate = new SpaceDelegate(view);
	var transition = WatchUi.SLIDE_IMMEDIATE;
	WatchUi.pushView(view, delegate, transition);
}

class Space extends WatchUi.View {
	var timer;
	var ship;
	var missiles = [];
	var timeOutCount = 0;
	function initialize() {
		View.initialize();
		timer = new Timer.Timer();
		timer.start(new Lang.Method(self, :driver), 100, true);
		ship = new Ship();	

	}

	function onUpdate(dc) {
		View.onUpdate(dc);
		dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_WHITE);
		dc.clear();
		dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_WHITE);
		ship.draw(dc);
		for (var i = 0; i < missiles.size(); i++) {
			missiles[i].draw(dc);
		}
	}

	function driver() {
		timeOutCount += 1;
		if (timeOutCount >= 300) {System.exit();}
		WatchUi.requestUpdate();
	}

	function drawShip() {

	}

	function clearScreen(dc) {
		dc.clear();
	}

}

class SpaceDelegate extends WatchUi.BehaviorDelegate {
	var view;
	function initialize(view) {
		self.view = view;
		BehaviorDelegate.initialize();
	}

	function onSelect() {
		var x = view.ship.x;
		var y = view.ship.y;
		var rotation = view.ship.rotation;
		var missile = new Missile(x, y, rotation);
		view.missiles.add(missile);
		//view.ship.gas();
	}

	function onNextPage() {
		view.ship.rotateClockWise();
	}

	function onPreviousPage() {
		view.ship.rotateCounterClockWise();
	}

	function onBack() {
		view.ship.shiftSpeed();
		return true;
	}
}

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
class Ship {
	var x;		// Coordinate
	var y; 		// Coordinate
	var direction; 	//degrees
	var width = 4;
	var color = Graphics.COLOR_BLACK;
	var rotation = 270; // degrees
	var speeds = [1,3,5];
	var speedIndex = 0;
	var gravity;
	function speed() { return speeds[speedIndex]; }
	function radians(degrees) { return degrees * (3.146) / 180; }
	function initialize() {
		x = 120;
		y = 120;
		gravity = new Gravity();
	}

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
			var newY = point[1] * Math.cos(radians(rotation)) - point[0] * Math.sin(radians(rotation)); 
			var newX = point[1] * Math.sin(radians(rotation)) + point[0] * Math.cos(radians(rotation)); 
			newX += x;
			newY += y;
			pts.add([newX, newY]);
		}
		
		return pts;
	}

	function rotateCounterClockWise() {
		rotation = (rotation - 10) >= 0 ? rotation - 10 : 359;
		System.println(rotation);
	}
	function rotateClockWise() {
		rotation = (rotation + 10) % 360;
		System.println(rotation);
	}

	function gas() {
		var next = getNextCoordinate();
		x += next[0];
		y += next[1];
		//gravity.setX(next[0]);
		//gravity.setY(next[y]);
	}

	function getNextCoordinate() {
		var y = speed() * Math.cos(radians(rotation));
		var x = speed() * Math.sin(radians(rotation));
		return [x,y];
	}

	function applyGravity() {
		var a = getNextCoordinate();
		x += a[0];
		y += a[1];
		//x += gravity.x;
		//y += gravity.y;
	}

	function shiftSpeed() {
		speedIndex = (speedIndex + 1) % 3;
	}
}
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
		dc.setPenWidth(5);
		dc.drawPoint(x, y);
	}

	function getNextCoordinate() {
		var speed = 10;
		var y = speed * Math.cos(radians(rotation));
		var x = speed * Math.sin(radians(rotation));
		return [x,y];
	}
}