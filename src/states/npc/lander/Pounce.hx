package states.npc.lander;

import components.update.HumanComponent;
import components.update.HumanFinderComponent;
import components.update.PosComponent;
import fsm.IState;
import ecs.Entity;
import fsm.FSMComponent;
import Planet;

class Pounce implements IState
{
	public var state:States=Lander(Pounce);

	public function new() {}
	
	public function enter(c:FSMComponent,e:Entity,dt:Float)
	{
		var pc:PosComponent = cast e.get(Pos);
		pc.dx = 0;
		pc.dy = 20;
	}


	public function update(c:FSMComponent,e:Entity,dt:Float)
	{
		var pc:PosComponent = cast e.get(Pos);
		pc.y=pc.y+pc.dy* Config.settings.grab_speed * dt;

		var fc:HumanFinderComponent = cast e.get(HumanFinder);
		var te = e.engine.getEntity(fc.target_id); 
		if ( te == null ) {
			fc.target_id = null;
			c.next_state = Lander(Search);
			return;
		} else {
			var tc:PosComponent = cast te.get(Pos);
			if ( pc.y > tc.y - 30 )
			{
				c.next_state = Lander(Kidnap);
			}
		}

		var m = e.engine.game.mountainAt(Std.int(pc.x)); 
		var wh = e.engine.game.s2d.height;

		if ( pc.y > wh - ( m + 100 ))
		{
			pc.dy = -50; 
		}
		if ( pc.y < wh - ( m + 100 ))
		{
			pc.dy = 50;
		}

	}

	public function exit(c:FSMComponent,e:Entity,dt:Float)
	{
	
	}

}
 