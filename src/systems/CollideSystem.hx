package systems;

import fsm.FSMComponent;
import components.update.CollideComponent;
import components.update.PosComponent;
import components.draw.DrawComponent;
import ecs.System;
import ecs.Filter;
import ecs.Entity;
import event.events.KilledEvent;
import event.events.HumanSaved;

class CollideSystem extends System implements ISystem {
	public function new() {
		super();
		this.type = CollideSystem;
		this.filter = new Filter();
		filter.add(Collide);
		filter.add(Pos);
	}

	public override function update(dt:Float) {
		for (e in this.targets) {
			var bd:DrawComponent = cast e.get(Draw);
			for (other in this.engine.getEntitiesWithComponent(Player)) {
				var od:DrawComponent = cast other.get(Draw);
				if (od.drawable.getBounds().intersects(bd.drawable.getBounds())) {
					if (e.has(Human)) {
						var hfsm:FSMComponent = cast e.get(FSM);
						if (hfsm.state.match(Human(Falling))) {
							var pos:PosComponent = cast e.get(Pos);
							MessageCentre.notify(new HumanSavedEvent(e, pos));
						}
					} else {
						MessageCentre.notify(new KilledEvent(e));
						MessageCentre.notify(new KilledEvent(other));
					}
				}
			}
			for (other in this.engine.getEntitiesWithComponent(Laser)) {
				var od:DrawComponent = cast other.get(Draw);
				if (od.drawable.getBounds().intersects(bd.drawable.getBounds())) {
					MessageCentre.notify(new KilledEvent(e));
				}
			}
		}
	}
}
