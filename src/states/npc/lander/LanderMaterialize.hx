package states.npc.lander;


import fsm.IState;
import ecs.Entity;
import fsm.FSMComponent;
import logging.Logging;
import Enums;

class LanderMaterialize implements IState
{
	public var state:States=Lander(Materialize);

	public function new() {}
	
	public function enter(c:FSMComponent,e:Entity)
	{
		Logging.trace("enter lander materialize");
	}
	public function update(c:FSMComponent,e:Entity)
	{
		Logging.trace("update lander materialize");
	}
	public function exit(c:FSMComponent,e:Entity)
	{}
}
 