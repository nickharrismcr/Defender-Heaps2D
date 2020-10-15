package states.npc.human;

import components.update.HumanComponent;
import components.update.PosComponent;
import event.events.HumanPlaced;
import fsm.IState;
import ecs.Entity;
import fsm.FSMComponent;

class Rescued implements IState {
	public var state:States = Human(Rescued);

	public function new() {}

	public function enter(c:FSMComponent, e:Entity, dt:Float) {
	}

	public function update(c:FSMComponent, e:Entity, dt:Float) {

		var pc:PosComponent = cast e.get(Pos);
		var ppc = e.engine.game.player_pos;
		pc.x = ppc.x + ppc.direction * 40;
		pc.y = ppc.y + 40;

		var mh = e.engine.game.mountainAt(Std.int(pc.x));
		var sh = e.engine.game.s2d.height;

		if (pc.y > sh - mh) {
			var h:HumanComponent = cast e.get(Human); 
			c.next_state = Human(Walk);
			MessageCentre.notify(new HumanPlacedEvent(e, pc));
		}
	}

	public function exit(c:FSMComponent, e:Entity, dt:Float) {}
}
