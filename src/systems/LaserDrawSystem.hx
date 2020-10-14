package systems;

import fsm.FSMComponent;
import h2d.Drawable;
import components.update.PosComponent;
import components.update.LaserComponent;
import ecs.System;
import ecs.Filter;
import ecs.Entity;
import Camera;

class LaserDrawSystem extends System implements ISystem {
	var scene:h2d.Scene;
	var gfx:h2d.Graphics;

	public function new(s2d:h2d.Scene) {
		super();
		this.type = LaserDrawSystem;
		this.filter = new Filter();
		this.filter.add(Laser);
		this.filter.add(Pos);
		this.scene = s2d;
		this.gfx = new h2d.Graphics(this.scene);
	}

	public override function onAddEntity(e:Entity) {}

	public override function onRemoveEntity(e:Entity) {}

	public override function update(dt:Float) {
		var sw = this.engine.game.s2d.width;
		var ww = Config.settings.world_width;

		this.gfx.clear();
		for (e in this.targets) {
			var pc:PosComponent = cast e.get(Pos);
			var posx=pc.x;
			if ( Camera.position < sw && pc.x > ww - sw )
				posx=posx-ww;
			if ( Camera.position > ww - sw && pc.x <  sw )
				posx=posx+ww;

			var lc:LaserComponent = cast e.get(Laser);

			this.gfx.beginFill(lc.color.toColor());
			this.gfx.drawRect(pc.x-Camera.position, pc.y, lc.length*lc.dir, 2);
			this.gfx.endFill();
		}
	}
}
