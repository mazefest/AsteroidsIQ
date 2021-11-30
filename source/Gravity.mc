class Gravity {
	var x;
	var y;
	var direction; // degrees
	var gravitationalSpeed;
	var maxGravitationalSpeed;

	function initialize() {
		x = 0;
		y = 0;
		maxGravitationalSpeed = 3.0;
		gravitationalSpeed = 2.0;
		direction = 270; 
	}
	
	function getNextCoordinate() {
		x = gravitationalSpeed * Math.sin(Util.radians(direction));
		y = gravitationalSpeed * Math.cos(Util.radians(direction));
	}

	function setY(value) { y = value; }
	function setX(value) { x = value; }
	function apply(object) {
		getNextCoordinate();
		object.x += x;
		object.y += y;
	}
	function forceFrom(rotation) {
		var tempOne = rotation - direction;
		var tempTwo = direction - rotation;
		var tempThree = (tempOne > 0.0) ? tempOne : tempTwo;
		if (tempThree >= 90 && tempThree <= 270) {
			gravitationalSpeed -= 0.5;	
			if (gravitationalSpeed <= 0.0) {
				gravitationalSpeed = 0.0;
				direction = rotation;
			}
		} else if (gravitationalSpeed < maxGravitationalSpeed) {
			gravitationalSpeed += 0.5;
		} else {
			var tempOneAbs = Util.abs(tempOne);
			var tempTwoAbs = Util.abs(tempTwo);
			if (tempOneAbs < tempTwoAbs) {
				direction += calculateRotationFrom(tempOne, tempOneAbs);
			} else {
				direction += calculateRotationFrom(tempTwo, tempTwoAbs);
			} 	
			if (gravitationalSpeed <  maxGravitationalSpeed) {
				gravitationalSpeed += 0.5;
			}
		}
	}

	function calculateRotationFrom(newRotation, newRotationAbs) {
		if (newRotation < 0) {
			return newRotationAbs / 2.0;
		} else {
			return (newRotationAbs / 2.0) * -1;
		}
	}

	function rotate(degrees) {
		direction += degrees;
		if (direction < 0) {
			direction += 360;
		} else if (direction >= 360) {
			direction %= 360;
		}
	}
}
