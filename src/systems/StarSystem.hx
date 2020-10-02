package systems;

import ecs.System;
import ecs.Filter;
import ecs.Entity;
import event.MessageCentre;
import Enums;
import logging.Logging;
import components.update.PosComponent;
import components.update.StarComponent;
import components.update.TimerComponent;

class StarSystem extends System implements ISystem
{
	var scene:h2d.Scene;
	var tile:h2d.Tile;

	public function new(scene:h2d.Scene )
	{
		super( );
		this.type=StarSystem;
		this.scene=scene;
		this.tile = h2d.Tile.fromColor(0xFFFFFF, 2, 2 );
		this.filter=new Filter();
		filter.add(Star); 
		filter.add(Timer);
		filter.add(Pos);
	}
	public override function onAddEntity(e:Entity)
	{	
		var dr:StarComponent = cast e.get(Star);
		dr.bmp = new h2d.Bitmap(this.tile);
		this.engine.app.s2d.addChild(dr.bmp);
		Logging.trace('Star Draw system onAddEntity ${e.id}');

	}

	public override function update(dt:Float)
	{
		for ( e in this.targets )
		{
			var t:TimerComponent = cast e.get(Timer);
			var s:StarComponent = cast e.get(Star);
			var p:PosComponent = cast e.get(Pos);
			if ( t.t > t.mark) {
				t.mark = t.t + 1 + hxd.Math.random(3);
				p.x = Std.random(scene.width); 
				p.y = Std.random(scene.height);
				s.col = Utils.rand_col();
				s.bmp.setPosition(p.x,p.y);
				s.bmp.color=s.col;
			}
		}
	}
}