package states.npc.lander;

import components.update.HumanFinderComponent;
import components.draw.DrawComponent;
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
		e.removeComponent(Draw);
		e.addComponent(new DrawComponent(GFX.getAnim(Mutant)));	

		var hfc:HumanFinderComponent = cast e.get(HumanFinder);
		var he = e.engine.getEntity(hfc.target_id);
		if ( he != null ) {
			var hfsm:FSMComponent = cast he.get(FSM);
			hfsm.next_state = Human(Die);
		}

	}


	public function update(c:FSMComponent,e:Entity,dt:Float)
	{
		 
	}

	public function exit(c:FSMComponent,e:Entity,dt:Float)
	{
	
	}

}
 