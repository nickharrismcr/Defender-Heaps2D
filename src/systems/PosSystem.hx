package systems;
 
import components.update.PosComponent;
 
import ecs.System;
import ecs.Filter;
import ecs.Entity;

 

 

class PosSystem extends System implements ISystem
{
	public function new( )
	{
		super( );
		this.type=PosSystem;
		this.filter=new Filter();
		filter.add(Pos);
	}

	public override function update(dt:Float)
	{
		for ( e in this.targets )
		{
			var bp:PosComponent = cast e.get(Pos);
			if ( bp.x < 0 ) bp.x += Config.settings.world_width;
			if ( bp.x > Config.settings.world_width ) bp.x -= Config.settings.world_width; 
		}
	}

	
}