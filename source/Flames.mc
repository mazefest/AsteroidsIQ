using Toybox.WatchUi;
using Toybox.Timer;
using Toybox.Graphics;
using Toybox.Lang;
using Toybox.Math;
using Toybox.System;

class Flames {
	var activated;
	var pointMap = [[0, -5], [0, -15]];
	function initialize() {
		activated = false;
	}

	function draw(dc, x, y, degrees) {
		if (!activated) { return; }
		
		dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_BLUE);
		dc.setPenWidth(6);
		var points = Util.rotatePoints([x,y], pointMap, degrees);
		var point1 = points[0];
		var point2 = points[1];
		dc.drawLine(point1[0], point1[1], point2[0], point2[1]);
		self.deactivate();
	}

	function activate() {
		self.activated = true;
	}

	function deactivate() {
		activated = false;
	}
}