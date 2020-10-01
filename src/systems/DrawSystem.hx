package systems;

import ecs.System;
import ecs.Filter;
import ecs.Entity;
import event.MessageCentre;
import Enums;
import logging.Logging;

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
		var drawable=e.get(Draw).drawable;
		this.engine.app.s2d.addChild(drawable);
	}

	public override function onRemoveEntity(e:Entity)
	{
		var drawable=e.get(Draw).drawable;
		this.engine.app.s2d.removeChild(drawable);
	}

	public override function update(dt:Float)
	{
		for ( e in this.targets )
		{
			var p=e.get(Pos);
			var d=e.get(Draw);
			d.drawable.setPosition(p.x,p.y);
		}
	}
	public function onEvent(ev:IEvent)
	{
		Logging.trace('Draw system got event ${ev.entity.id}');
	}
}