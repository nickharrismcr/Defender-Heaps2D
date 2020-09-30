package states.npc.lander;


import fsm.IState;
import fsm.FSMComponent;
import ecs.Entity;
import logging.Logging;
import Enums;
import components.update.PosComponent;


class LanderWait implements IState
{
	public var state:States=Lander(Wait);

	public function new() {}

	public function enter(c:FSMComponent,e:Entity)
	{
		Logging.trace("enter landerwait");
		
	}
	public function update(c:FSMComponent,e:Entity)
	{
	
		var pos:PosComponent = cast e.get(Pos);
		pos.x = pos.x + 1;
		if ( pos.x > 2 ) {
			c.next_state=(Lander(Materialize));
		}
		Logging.trace('update landerwait ${pos.x} ${c.state} ${c.next_state}');
			
	}
	public function exit(c:FSMComponent,e:Entity)
	{}
}