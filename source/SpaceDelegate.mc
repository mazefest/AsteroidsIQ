using Toybox.WatchUi;

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