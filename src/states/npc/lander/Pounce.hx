package states.npc.lander;

import components.update.HumanComponent;
import components.update.HumanFinderComponent;
import components.update.PosComponent;
import fsm.IState;
import ecs.Entity;
import fsm.FSMComponent;
import Planet;

class Pounce implements IState {
	public var state:States = Lander(Pounce);

	public function new() {}

	public function enter(c:FSMComponent, e:Entity, dt:Float) {
		var pc:PosComponent = cast e.get(Pos);
		pc.dx = 0;
		pc.dy = Config.getGrabSpeed();
	}

	public function update(c:FSMComponent, e:Entity, dt:Float) {
		var pc:PosComponent = cast e.get(Pos);
		var fc:HumanFinderComponent = cast e.get(HumanFinder);
		var te = e.engine.getEntity(fc.target_id);
		if (te == null) {
			fc.target_id = null;
			c.next_state = Lander(Search);
			return;
		} else {
			var tc:PosComponent = cast te.get(Pos);
			if (pc.y > tc.y - 30) {
				var tf:FSMComponent = cast te.get(FSM);
				if (tf.state.match(Human(Walk))) {
					tf.next_state = Human(Grabbed);
					c.next_state = Lander(Kidnap);
				} else {
					c.next_state = Lander(Search);
				}
			}
		}
	}

	public function exit(c:FSMComponent, e:Entity, dt:Float) {}
}
