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

class Kidnap implements IState
{
	public var state:States=Lander(Kidnap);

	public function new() {}
	
	public function enter(c:FSMComponent,e:Entity,dt:Float)
	{
		var pc:PosComponent = cast e.get(Pos);
		pc.dy = - Config.settings.grab_speed;
	}


	public function update(c:FSMComponent,e:Entity,dt:Float)
	{
		var pc:PosComponent = cast e.get(Pos);
		pc.x=pc.x+pc.dx*dt;
		pc.y=pc.y+pc.dy*dt;

		if ( pc.y < 200 ){
			c.next_state = Lander(Mutant);
		}
		 
	}

	public function exit(c:FSMComponent,e:Entity,dt:Float)
	{
	
	}

}
 