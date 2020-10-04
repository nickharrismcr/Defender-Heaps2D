package systems;

import components.update.CollideComponent;
import components.update.PosComponent;
 
import ecs.System;
import ecs.Filter;
import ecs.Entity;




class CollideSystem extends System implements ISystem
{
	public function new( )
	{
		super( );
		this.type=CollideSystem;
		this.filter=new Filter();
		filter.add(Collide); 
		filter.add(Pos);
 
	}

 
	public override function update(dt:Float)
	{
		for ( e in this.targets )
		{
			var p:DrawComponent = cast e.get(Draw);
			var t:CollideComponent = cast e.get(Collide);
		}
	}

	
}