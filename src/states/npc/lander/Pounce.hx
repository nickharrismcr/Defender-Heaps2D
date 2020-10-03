package states.npc.lander;

import components.update.ShootableComponent;
import event.events.FireBulletEvent;
import components.update.PosComponent;
import fsm.IState;
import ecs.Entity;
import fsm.FSMComponent;
import components.update.TimerComponent;
import logging.Logging;
import Enums;
import event.MessageCentre;
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
		pc.x=pc.x+pc.dx*dt;
		pc.y=pc.y+pc.dy*dt;

		var m = e.engine.game.mountainAt(Std.int(pc.x)); 
		var wh = e.engine.app.s2d.height;

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
 