package systems;

import format.swf.Constants.TagId;
import components.update.PosComponent;
import components.update.TimerComponent;
import components.update.LaserComponent;
import components.update.LifeComponent;
import components.draw.DrawComponent;
import event.events.KilledEvent;
import event.events.FireLaserEvent;
import ecs.System;
import ecs.Filter;
import ecs.Entity;

class LaserSystem extends System implements ISystem {
	var colors:Array<h3d.Vector>;
	var col_idx:Int;

	public function new() {
		super();
		this.type = LaserSystem;
		this.filter = new Filter();
		filter.add(Laser);
		filter.add(Pos);
		this.colors = [
			 Utils.green,  Utils.green,  Utils.green,  Utils.green,
			Utils.yellow, Utils.yellow, Utils.yellow, Utils.yellow,
			  Utils.cyan,   Utils.cyan,   Utils.cyan,   Utils.cyan,
			  Utils.blue,   Utils.blue,   Utils.blue,   Utils.blue
		];
		this.col_idx = 0;
	}

	public function fireEvent(event:IEvent) {
		var ev:FireLaserEvent = cast event;
		this.fire(ev.firer);
	}

	public function fire(firer:PosComponent) {
		if (this.engine.getEntitiesWithComponent(Laser).length > 8)
			return;
		var e = new Entity();
		var p = new PosComponent();
		p.x = firer.x + firer.direction * 180;
		p.y = firer.y;
		p.direction = firer.direction;
		p.kill_off_screen = true;

		p.dx = 400 * p.direction;
		p.dy = 0;
		e.addComponent(p);
		var lc = new LaserComponent();
		lc.length = 0;
		lc.dir = p.direction;
		lc.color = this.nextcolor();
		e.addComponent(lc);
		e.addComponent(new LifeComponent(2));
		var tc = new TimerComponent();
		tc.mark = 0.2;
		e.addComponent(tc);
		this.engine.addEntity(e);
	}

	public override function update(dt:Float) {
		var ww = Config.settings.world_width;

		for (e in this.targets) {
			var lc:LaserComponent = cast e.get(Laser);
			if (lc.length < e.engine.game.s2d.width)
				lc.length += 1800 * dt;
			var pos:PosComponent = cast e.get(Pos);
			pos.x += pos.direction * Math.abs(e.engine.game.player_pos.dx) * dt;
			lc.bounds.x = pos.screen_x - (lc.dir == -1 ? lc.length : 0);
			lc.bounds.y = pos.y;
			lc.bounds.width = lc.length;
			lc.bounds.height = 2;

			// gaps
			var tc:TimerComponent = cast e.get(Timer);
			if (tc.t > tc.mark) {
				var i = 0;
				for (g in lc.gaps) {
					i += Std.random(200);
					g[0] = i;
					g[1] = Std.random(30);
				}
				tc.mark = tc.t+0.1;
			}

			// collisions

			for (other in this.engine.getEntitiesWithComponent(Shootable)) {
				var op:PosComponent = cast other.get(Pos);
				if (e.engine.game.onScreen(op.screen_x)) {
					var od:DrawComponent = cast other.get(Draw);
					var ob = od.drawable.getBounds();
					ob.x = op.screen_x;

					if (ob.intersects(lc.bounds)) {
						this.engine.removeEntity(e);
						MessageCentre.notify(new KilledEvent(other));
					}
				}
			}
		}
	}

	private function nextcolor():h3d.Vector {
		return this.colors[(this.col_idx++) % 16];
	}
}
