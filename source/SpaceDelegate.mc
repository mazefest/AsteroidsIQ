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
	}

	function onNextPage() {
		view.ship.rotateClockWise();
	}

	function onPreviousPage() {
		view.ship.rotateCounterClockWise();
	}

	function onBack() {
		switch(view.gameState) {
			case home:
				view.reset();
				view.gameState = active;
				break;
			case active:
				view.ship.shiftSpeed();
				break;
			case gameOver:
				view.gameState = home;
				view.reset();
				break;
		}
		return true;
	}
}