package states.npc.lander;

import event.events.FireBulletEvent;
import components.update.PosComponent;
import fsm.IState;
import ecs.Entity;
import fsm.FSMComponent;
import components.update.HumanFinderComponent;

class Kidnap implements IState {
	public var state:States = Lander(Kidnap);

	public function new() {}

	public function enter(c:FSMComponent, e:Entity, dt:Float) {
		var pc:PosComponent = cast e.get(Pos);
		pc.dy = -Config.getGrabSpeed();
		pc.dx = 0;
	}

	public function update(c:FSMComponent, e:Entity, dt:Float) {
		var fc:HumanFinderComponent = cast e.get(HumanFinder);
		var te = e.engine.getEntity(fc.target_id);
		if (te == null) {
			fc.target_id = null;
			c.next_state = Lander(Search);
			return;
		}

		var pc:PosComponent = cast e.get(Pos);
		if (pc.y < Config.settings.play_area_start + 60) {
			c.next_state = Lander(Mutant);
		}
	}

	public function exit(c:FSMComponent, e:Entity, dt:Float) {}
}
