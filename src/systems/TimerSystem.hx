package systems;

import ecs.System;
import ecs.Filter;
import ecs.Entity;




class TimerSystem extends System implements ISystem
{
	public function new( )
	{
		super( );
		this.type=TimerSystem;
		this.filter=new Filter();
		filter.add(Timer); 
	}

	public override function update(dt:Float)
	{
		for ( e in this.targets )
		{
			var t=e.get(Timer);
			t.t = t.t + dt;
		}
	}
}