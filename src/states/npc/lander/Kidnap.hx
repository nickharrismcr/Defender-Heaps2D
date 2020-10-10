package states.npc.lander;

import event.events.FireBulletEvent;
import components.update.PosComponent;
import fsm.IState;
import ecs.Entity;
import fsm.FSMComponent;
import components.update.TimerComponent;
import Planet;

class Kidnap implements IState {
	public var state:States = Lander(Kidnap);

	public function new() {}

	public function enter(c:FSMComponent, e:Entity, dt:Float) {
		var pc:PosComponent = cast e.get(Pos);
		pc.dy = -Config.settings.grab_speed;
		pc.dx = 0;
	}

	public function update(c:FSMComponent, e:Entity, dt:Float) {
		var pc:PosComponent = cast e.get(Pos);

		if (pc.y < Config.settings.play_area_start + 60) {
			c.next_state = Lander(Mutant);
		}
	}

	public function exit(c:FSMComponent, e:Entity, dt:Float) {}
}
