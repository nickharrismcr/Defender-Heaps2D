package states;


import fsm.IState;
import ecs.Entity;
import fsm.FSMComponent;
import logging.Logging;
import Enums;
import components.update.TimerComponent;

class TestStop implements IState
{
	public var state:States=TestStop;

	public function new() {}
	
	public function enter(c:FSMComponent,e:Entity,dt:Float)
	{
		var tc:TimerComponent = cast e.get(Timer);
		tc.mark = tc.t + hxd.Math.random();
		 
	}
	public function update(c:FSMComponent,e:Entity,dt:Float)
	{
		var tc:TimerComponent = cast e.get(Timer);
		if ( tc.t > tc.mark )
		{
			e.get(FSM).next_state = TestMove;
		}
	}
	public function exit(c:FSMComponent,e:Entity,dt:Float)
	{}
}
 