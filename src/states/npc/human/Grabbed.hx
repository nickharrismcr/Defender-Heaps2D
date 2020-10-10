package states.npc.human;

import components.update.HumanComponent;
import components.update.PosComponent;
import components.draw.DrawComponent;
import fsm.IState;
import ecs.Entity;
import fsm.FSMComponent;
import components.update.TimerComponent;
import components.draw.DrawDisperseComponent;

class Grabbed implements IState {
	public var state:States = Human(Grabbed);

	public function new() {}

	public function enter(c:FSMComponent, e:Entity, dt:Float) {}

	public function update(c:FSMComponent, e:Entity, dt:Float) {
		var h:HumanComponent = cast e.get(Human);
		var pe = e.engine.getEntity(h.lander);
		if (pe == null) {
			return;
		}
		var pp:PosComponent = cast pe.get(Pos);
		var p:PosComponent = cast e.get(Pos);
		p.y = pp.y + 30;
	}

	public function exit(c:FSMComponent, e:Entity, dt:Float) {}
}
