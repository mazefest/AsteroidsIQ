
import Toybox.System;
import Toybox.Application.Storage;


class DataStore {
    var highScoreKey = "highScore";

    function initialize() {

    }

    function setHighScore(value) {
        Storage.setValue(highScoreKey, value);
    }

    function  getHighScore() {
        var value = Storage.getValue(highScoreKey); 
        return (value == null) ? 0 : value;
    }
}