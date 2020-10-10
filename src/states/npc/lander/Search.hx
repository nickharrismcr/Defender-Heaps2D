package states.npc.lander;

import components.update.HumanComponent;
import components.update.CollideComponent;
import event.events.FireBulletEvent;
import components.update.PosComponent;
import components.update.HumanFinderComponent;
import fsm.IState;
import ecs.Entity;
import fsm.FSMComponent;
import Planet;

class Search implements IState {
	public var state:States = Lander(Search);

	public function new() {}

	public function enter(c:FSMComponent, e:Entity, dt:Float) {
		e.addComponent(new CollideComponent());

		var pc:PosComponent = cast e.get(Pos);
		pc.dx = Std.random(2) == 1 ? -100 : 100;
		if (Std.random(2) == 1)
			pc.dx = -pc.dx;
		pc.dy = 80;
		var fc:HumanFinderComponent = cast e.get(HumanFinder);
		this.find_human(e, fc);
	}

	public function update(c:FSMComponent, e:Entity, dt:Float) {
		var pc:PosComponent = cast e.get(Pos);

		var m = e.engine.game.mountainAt(Std.int(pc.x));
		var wh = e.engine.game.s2d.height;

		if (pc.y > wh - (m + 200)) {
			pc.dy = -50;
		}
		if (pc.y < wh - (m + 200)) {
			pc.dy = 50;
		}
		var fc:HumanFinderComponent = cast e.get(HumanFinder);
		if ((fc.target_id == null) || (e.engine.getEntity(fc.target_id) == null)) {
			this.find_human(e, fc);
		}
		if (fc.target_id != null) {
			var te = e.engine.getEntity(fc.target_id);
			var tp:PosComponent = cast te.get(Pos);
			if (Math.abs(tp.x - (pc.x + 15)) < 2) {
				c.next_state = Lander(Pounce);
			}
		}

		if (Math.abs(pc.x - Camera.position) < e.engine.game.s2d.width) {
			if (Std.random(600) < 3) {
				MessageCentre.notify(new FireBulletEvent(e, pc, e.engine.game.player_pos));
			}
		}
	}

	public function exit(c:FSMComponent, e:Entity, dt:Float) {}

	private function find_human(e:Entity, fc:HumanFinderComponent) {
		fc.target_id = null;
		Logging.trace('Lander ${e.id} search find human');
		for (he in e.engine.getEntitiesWithComponent(Human)) {
			var hc:HumanComponent = cast he.get(Human);
			if (hc.lander == null) {
				hc.lander = e.id;
				fc.target_id = he.id;
				Logging.trace('Lander ${e.id} search found human ${he.id}');
				break;
			}
		}
	}
}
