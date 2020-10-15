package states.game;

import fsm.IState;
import ecs.Entity;
import fsm.FSMComponent;

class GameOver implements IState {
	public var state:States = Game(GameOver);

	public function new() {}

	public function enter(c:FSMComponent, e:Entity, dt:Float) {
		 
	}

	public function update(c:FSMComponent, e:Entity, dt:Float) {
		 
	}

	public function exit(c:FSMComponent, e:Entity, dt:Float) {}
}
