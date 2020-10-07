package states.player;
 
import fsm.IState;
import ecs.Entity;
import fsm.FSMComponent;


import components.update.TimerComponent;
import components.update.PosComponent;
import components.draw.DrawComponent;
import components.draw.DrawDisperseComponent;

class Explode implements IState
{
	public var state:States=Player(Explode);

	public function new() {}
	
	public function enter(c:FSMComponent,e:Entity,dt:Float)
	{
		e.removeComponent(Draw);
	}

	public function update(c:FSMComponent,e:Entity,dt:Float)
	{
		var tc:TimerComponent = cast e.get(Timer);
	 
	}
	public function exit(c:FSMComponent,e:Entity,dt:Float)
	{
		 
		 
	}
}
 