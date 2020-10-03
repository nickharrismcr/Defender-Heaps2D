package systems;

import h2d.Drawable;
import components.update.PosComponent;
import components.draw.DrawComponent;
import ecs.System;
import ecs.Filter;
import ecs.Entity;
import event.MessageCentre;
import Enums;
import logging.Logging;
import Camera;

class DrawSystem extends System implements ISystem
{

	public function new( )
	{
		super( );
		this.type=DrawSystem;
		this.filter=new Filter();
		filter.add(Draw); 
		filter.add(Pos);
	}

	public override function onAddEntity(e:Entity)
	{
		var dr:DrawComponent = cast e.get(Draw);
		this.engine.app.s2d.addChild(dr.drawable);
		Logging.trace('Draw system onAddEntity $e add child at ${dr.drawable.x},${dr.drawable.y}');
	}

	public override function onRemoveEntity(e:Entity)
	{
        Logging.trace('Draw system onRemoveEntity $e');
		var dr:DrawComponent = cast e.get(Draw);
		this.engine.app.s2d.removeChild(dr.drawable);
	}

	public override function update(dt:Float)
	{
		var sw = this.engine.app.s2d.width;
		var ww = Config.settings.world_width;

		for ( e in this.targets )
		{
			var p:PosComponent = cast e.get(Pos);
			var d:DrawComponent = cast e.get(Draw);
			var posx=p.x;
			if ( Camera.position < sw && p.x > ww - sw )
				posx=posx-ww;
			if ( Camera.position > ww - sw && p.x <  sw )
				posx=posx+ww;

			d.drawable.setPosition(posx-Camera.position,p.y);
		}
	}

	public function onEvent(ev:IEvent)
	{
		Logging.trace('Draw system got event ${ev.entity.id}');
	}
}  