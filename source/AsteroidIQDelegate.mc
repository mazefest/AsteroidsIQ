import Toybox.Lang;
import Toybox.WatchUi;

class AsteroidIQDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() as Boolean {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new AsteroidIQMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

}