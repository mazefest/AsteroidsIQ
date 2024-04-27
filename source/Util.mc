
using Toybox.Math;

class Util {
	static function abs(value) {
		return (value * -1) > 0 ? (value * -1) : value;
	}
	
	static function radians(degrees) { 
		return degrees * (3.146) / 180; 
	}

	// @rotation: Double -> The amount you want the points rotated in degrees
	// @originPointMap: [[Int, Int]] is an array of the points based arround the origin 0,0
	// @center: [Int, Int] the center of where the points will be after rotating
	static function rotatePoints(center, originPointMap, rotation) {
		var x = center[0];
		var y = center[1];
		var pts = [];
		var points = originPointMap;
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

	// returns the distance between 2 points.
	static function distanceBetween(pointA, pointB) {
		var a = Math.pow((pointA.x - pointB.x), 2) + Math.pow((pointA.y - pointB.y), 2);
		var value = Math.sqrt(a);
		return value;
	}
}