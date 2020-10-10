package states.npc.human;

import components.update.HumanComponent;
import haxe.display.Display.Package;
import components.update.PosComponent;
import components.draw.DrawComponent;
import event.events.HumanLanded;
import fsm.IState;
import ecs.Entity;
import fsm.FSMComponent;

class Falling implements IState {
	public var state:States = Human(Falling);

	public function new() {}

	public function enter(c:FSMComponent, e:Entity, dt:Float) {
		var pc:PosComponent = cast e.get(Pos);
		pc.dy = 20;
		var h:HumanComponent = cast e.get(Human);
		h.dropped_height = Std.int(pc.y);
	}

	public function update(c:FSMComponent, e:Entity, dt:Float) {
		var pc:PosComponent = cast e.get(Pos);
		pc.dy = pc.dy + (dt * 200);
		// Logging.trace('falling e ${e.id}  y ${pc.y} dy ${pc.dy} dt {$dt}');

		var mh = e.engine.game.mountainAt(Std.int(pc.x));
		var sh = e.engine.game.s2d.height;

		if (pc.y > sh - mh) {
			var h:HumanComponent = cast e.get(Human);
			if (h.dropped_height > sh / 2) {
				c.next_state = Human(Walk);
				MessageCentre.notify(new HumanLandedEvent(e, pc));
			} else {
				c.next_state = Human(Die);
			}
		}
	}

	public function exit(c:FSMComponent, e:Entity, dt:Float) {}
}
