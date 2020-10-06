package systems;

import components.update.LifeComponent;
import ecs.System;
import ecs.Filter;
import ecs.Entity;

class LifeSystem extends System implements ISystem
{
	public function new( )
	{
		super( );
		this.type=LifeSystem;
		this.filter=new Filter();
		filter.add(Life); 
	}

	public override function update(dt:Float)
	{
		for ( e in this.targets )
		{
			var t:LifeComponent = cast e.get(Life);
			t.t = t.t + dt;
			if ( t.t > t.life )
			{
				e.engine.removeEntity(e);
			}
		}
	}
}