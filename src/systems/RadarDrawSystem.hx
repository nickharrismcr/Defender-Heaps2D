package systems;

import components.update.HumanFinderComponent;
import fsm.FSMComponent;
import h2d.Drawable;
import components.update.PosComponent;
import components.draw.RadarDrawComponent;
import ecs.System;
import ecs.Filter;
import ecs.Entity;



import Camera;

class RadarDrawSystem extends System implements ISystem
{
	var gfx:h2d.Graphics;

	public function new(s2d:h2d.Scene )
	{
		super( );
		this.type=RadarDrawSystem;
		this.filter=new Filter();
		filter.add(RadarDraw); 
		filter.add(Pos);
		gfx = new h2d.Graphics(s2d);
	}

 
	public override function onAddEntity(e:Entity)
	{
		var dr:RadarDrawComponent = cast e.get(RadarDraw);
		this.engine.game.s2d.addChild(dr.udrawable);
		this.engine.game.s2d.addChild(dr.ldrawable);
		Logging.trace('Draw system onAddEntity $e add child at ${dr.udrawable.x},${dr.udrawable.y}');
	}

	public override function onRemoveEntity(e:Entity)
	{
        Logging.trace('Draw system onRemoveEntity $e'); 
		var dr:RadarDrawComponent = cast e.get(RadarDraw);
		this.engine.game.s2d.removeChild(dr.udrawable);
		this.engine.game.s2d.removeChild(dr.ldrawable);
	}

	public override function update(dt:Float)
	{
		var sw = this.engine.game.s2d.width;
		var sh = this.engine.game.s2d.height;
		var rxs = sw*0.25;
		var rxe = sw*0.75;
		var rw = rxe-rxs;
		var rye = Config.settings.play_area_start-50;
		var ww = Config.settings.world_width;
		var rsw = rw * (sw/ww);

		gfx.clear(); 
		gfx.beginFill(0x000099); 
		gfx.drawRect(0,rye+20,sw,3);
		gfx.drawRect(rxs-20,0,3,rye+20);
		gfx.drawRect(rxe+20,0,3,rye+20);
		gfx.endFill();
		gfx.beginFill(0xffffff);
		gfx.drawRect((sw/2)-(rsw/2),0,rsw,3); 
		gfx.drawRect((sw/2)-(rsw/2),rye+17,rsw,3);
		gfx.endFill();

		for ( e in this.targets )
		{
			var p:PosComponent = cast e.get(Pos);
			var d:RadarDrawComponent = cast e.get(RadarDraw);
			var posx=   ww/2 + p.x - Camera.position - sw/2;
			if ( posx > ww )
				posx=posx-ww;
			if ( posx < 0  )
				posx=posx+ww;

			d.udrawable.setPosition(rxs+rw*(posx/ww), p.y*(rye/sh));
			d.udrawable.color = d.ucolors[d.idx];
			d.ldrawable.setPosition(rxs+rw*(posx/ww), 3+(p.y*(rye/sh)));
			d.ldrawable.color = d.lcolors[d.idx];
			d.t += dt;
			if ( d.t > 0.1 ){
				d.t = 0;
				d.idx++;
				if ( d.idx == d.ucolors.length ){
					d.idx = 0;
				}
			}
		}
	}

	public function onEvent(ev:IEvent)
	{
		Logging.trace('Draw system got event ${ev.entity.id}');
	}
}  