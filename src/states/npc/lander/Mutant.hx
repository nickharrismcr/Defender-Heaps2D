package states.npc.lander;

import components.update.HumanFinderComponent;
import components.draw.DrawComponent;
import components.draw.RadarDrawComponent;
import event.events.FireBulletEvent;
import components.update.PosComponent;
import fsm.IState;
import ecs.Entity;
import fsm.FSMComponent;
import components.update.TimerComponent;
import Planet;

class Mutant implements IState {
	public var state:States = Lander(Mutant);

	public function new() {}

	public function enter(c:FSMComponent, e:Entity, dt:Float) {
		e.removeComponent(Draw);
		e.removeComponent(RadarDraw);
		e.addComponent(new DrawComponent(GFX.getAnim(Mutant)));
		var dc = new RadarDrawComponent(e.engine.game.factory.radartile, Mutant);
		e.addComponent(dc);

		var hfc:HumanFinderComponent = cast e.get(HumanFinder);
		var he = e.engine.getEntity(hfc.target_id);
		if (he != null) {
			var hfsm:FSMComponent = cast he.get(FSM);
			hfsm.next_state = Human(Die);
		}
		var tc:TimerComponent = cast e.get(Timer);
		tc.mark = tc.t + 0.1;
	}

	public function update(c:FSMComponent, e:Entity, dt:Float) {
		var pc:PosComponent = cast e.get(Pos);
		var tc:TimerComponent = cast e.get(Timer);
		if (tc.t > tc.mark) {
			tc.mark = tc.t + 0.1;

			pc.dx = Std.random(2) == 1 ? -400 : 400;
			pc.dy = Std.random(2) == 1 ? -400 : 400;
			pc.dx = pc.dx + (800 * (e.engine.game.player_pos.x > pc.x ? 1 : -1));
		}

		if (e.engine.game.onScreen(pc.x)) {
			if (Std.random(600) < 3) {
				MessageCentre.notify(new FireBulletEvent(e, pc, e.engine.game.player_pos));
			}
		}
	}

	public function exit(c:FSMComponent, e:Entity, dt:Float) {}
}
