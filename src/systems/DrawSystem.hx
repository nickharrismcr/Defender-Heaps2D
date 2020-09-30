package systems;

import ecs.System;
import ecs.Filter;
import event.MessageCentre;
import Enums;
import logging.Logging;

class DrawSystem extends System implements ISystem
{
	public function new()
	{
		super();
		this.type=Draw;
		this.filter=new Filter();
		filter.add(Draw); 
	}
	public override function update(dt:Float)
	{
		for ( k => e in this.targets )
		{
			Logging.trace('Draw system update ${e.id}');
		}
	}
	public function onEvent(ev:IEvent)
	{
		Logging.trace('Draw system got event ${ev.entity.id}');
	}
}