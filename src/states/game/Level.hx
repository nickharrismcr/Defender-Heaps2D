package states.game;


import fsm.IState;
import ecs.Entity;
import fsm.FSMComponent;
 

class Level implements IState {
	public var state:States = Game(Level);

	public function new() {}

	public function enter(c:FSMComponent, e:Entity, dt:Float) {
        
        var f = e.engine.game.factory.addPlayerFunc();
		f();
		var f = e.engine.game.factory.addHumansFunc(Config.levels.humans);
		e.engine.schedule(0.1, f);
        var landers=Std.int(Config.getLanders()/3);
        var f = e.engine.game.factory.addLandersFunc(landers);
        e.engine.schedule(3,f);
        e.engine.schedule(13,f);
        e.engine.schedule(23,f);
	}

	public function update(c:FSMComponent, e:Entity, dt:Float) {
		 if ( e.engine.game.landers_killed == Config.getLanders()) {
			 c.next_state = Game(LevelEnd);
		 }
	}

	public function exit(c:FSMComponent, e:Entity, dt:Float) {
		 
	}
}
