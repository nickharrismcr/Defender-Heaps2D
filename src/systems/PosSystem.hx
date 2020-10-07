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
		var ps = Config.settings.play_area_start;
		var pe = this.engine.game.s2d.height;

		for ( e in this.targets )
		{
			if (e.engine.game.freeze ) return;
			
			var bp:PosComponent = cast e.get(Pos);
			bp.x = bp.x + bp.dx * dt;
			bp.y = bp.y + bp.dy * dt;
			if ( bp.y < ps  ) {
				if (bp.kill_off_screen){
					e.engine.removeEntity(e);
				} else { 
					bp.y = ps;
				}
			}
			if ( bp.y > pe ) {
				if (bp.kill_off_screen){
					e.engine.removeEntity(e);
				} else { 
					bp.y = pe;
				}
			}	
			
			if ( bp.x < 0 ) bp.x += Config.settings.world_width;
			if ( bp.x > Config.settings.world_width ) bp.x -= Config.settings.world_width; 
		}
	}

	
}