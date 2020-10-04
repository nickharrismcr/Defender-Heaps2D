package states.npc.lander;

import components.update.ShootableComponent;
import event.events.FireBulletEvent;
import components.update.PosComponent;
import fsm.IState;
import ecs.Entity;
import fsm.FSMComponent;
import components.update.TimerComponent;



import Planet;

class Mutant implements IState
{
	public var state:States=Lander(Mutant);

	public function new() {}
	
	public function enter(c:FSMComponent,e:Entity,dt:Float)
	{
		 
	}


	public function update(c:FSMComponent,e:Entity,dt:Float)
	{
		 
	}

	public function exit(c:FSMComponent,e:Entity,dt:Float)
	{
	
	}

}
 