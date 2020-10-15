package states.game;

import components.update.TimerComponent;
import fsm.IState;
import ecs.Entity;
import fsm.FSMComponent;
import event.events.LevelEnd;

class LevelEnd implements IState {
	public var state:States = Game(LevelEnd);

	public function new() {}

	public function enter(c:FSMComponent, e:Entity, dt:Float) {
		MessageCentre.notify(new LevelEndEvent());
		var tc:TimerComponent = cast e.get(Timer);
		tc.mark = tc.t + 4;
		e.engine.game.hud.addText('ATTACK WAVE ${Config.levels.level+1} COMPLETED');
	}

	public function update(c:FSMComponent, e:Entity, dt:Float) {
		var tc:TimerComponent = cast e.get(Timer);
		if ( tc.t > tc.mark ){
			c.next_state = Game(LevelStart);
		}
	}

	public function exit(c:FSMComponent, e:Entity, dt:Float) {
		e.engine.game.hud.clearText();
	}
}
