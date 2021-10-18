import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class AsteroidIQApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
    }

    // Return the initial view of your application here
    function getInitialView() as Array<Views or InputDelegates>? {
        var view = new Space();
        var delegate = new SpaceDelegate(view); 
        return [view, delegate];
        //return [ new AsteroidIQView(), new AsteroidIQDelegate() ] as Array<Views or InputDelegates>;
    }

}

function getApp() as AsteroidIQApp {
    return Application.getApp() as AsteroidIQApp;
}