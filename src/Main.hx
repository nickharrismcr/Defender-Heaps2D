 
import hxd.Window.DisplayMode;
import Game;
import logging.Logging;

class Main extends hxd.App { 

	var win:hxd.Window;
	var game:Game;

	override function init() {

		Logging.level=ERROR;
		win=hxd.Window.getInstance();
		 win.displayMode=Fullscreen;
		game=new Game(this);
		 
	}
	// on each frame
	override function update(dt:Float) {
		 game.update(dt);
	}

	static function main() {
		new Main();
	}
}







