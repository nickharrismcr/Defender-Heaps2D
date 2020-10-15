package states.game;

import event.events.LevelStart;
import fsm.IState;
import ecs.Entity;
import fsm.FSMComponent;

class LevelStart implements IState {
	public var state:States = Game(LevelStart);

	public function new() {}

	public function enter(c:FSMComponent, e:Entity, dt:Float) {
		MessageCentre.notify(new LevelStartEvent());
	}

	public function update(c:FSMComponent, e:Entity, dt:Float) {
        c.next_state = Game(Level);
    }

	public function exit(c:FSMComponent, e:Entity, dt:Float) {}
}
