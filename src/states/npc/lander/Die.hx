package states.npc.lander;

import components.update.HumanFinderComponent;
import components.draw.DrawComponent;
import components.update.TimerComponent;
import components.draw.DrawDisperseComponent;
import fsm.IState;
import ecs.Entity;
import fsm.FSMComponent;

class Die implements IState {
	public var state:States = Lander(Die);

	public function new() {}

	public function enter(c:FSMComponent, e:Entity, dt:Float) {
		var tc:TimerComponent = cast e.get(Timer);
		tc.mark = tc.t + 1 + 2 * hxd.Math.random();
		e.removeComponent(Draw);
		e.removeComponent(Collide);
		e.removeComponent(RadarDraw);
		e.addComponent(new DrawDisperseComponent(GFX.getDisperse(c.state.match(Lander(Mutant)) ? Mutant : Lander)));

		var hf:HumanFinderComponent = cast e.get(HumanFinder);
		if (hf.target_id != null) {
			var he = e.engine.getEntity(hf.target_id);
			if (he != null) {
				var hf:FSMComponent = cast he.get(FSM);
				if (hf.state.match(Human(Grabbed))) {
					hf.next_state = Human(Falling);
				}
			}
		}
	}

	public function update(c:FSMComponent, e:Entity, dt:Float) {
		var tc:TimerComponent = cast e.get(Timer);
		var dr:DrawDisperseComponent = cast e.get(DrawDisperse);
		dr.disperse = dr.disperse + dt * 60;

		if (tc.t > tc.mark) {
			e.engine.removeEntity(e);
		}
	}

	public function exit(c:FSMComponent, e:Entity, dt:Float) {}
}
