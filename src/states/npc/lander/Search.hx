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

class Search implements IState
{
	public var state:States=Lander(Search);

	public function new() {}
	
	public function enter(c:FSMComponent,e:Entity,dt:Float)
	{
		e.addComponent(new ShootableComponent());
	}


	public function update(c:FSMComponent,e:Entity,dt:Float)
	{
		var pc = e.get(Pos);
		pc.x=pc.x+pc.dx*dt;
		pc.y=pc.y+pc.dy*dt;
		if ( pc.x < 0 || pc.x > e.engine.app.s2d.width )
		{
			pc.dx=-pc.dx;
		}
		if ( pc.y < 0 || pc.y > e.engine.app.s2d.height )
		{
			pc.dy=-pc.dy;
		}

		
		
		 
	}

	public function exit(c:FSMComponent,e:Entity,dt:Float)
	{
	
	}

}
 