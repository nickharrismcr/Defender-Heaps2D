package states.npc.lander;


import components.draw.DrawComponent;
import fsm.IState;
import ecs.Entity;
import fsm.FSMComponent;
import logging.Logging;
import Enums;
import components.update.TimerComponent;
import components.draw.DrawDisperseComponent;

class Die implements IState
{
	public var state:States=Lander(Die);

	public function new() {}
	
	public function enter(c:FSMComponent,e:Entity,dt:Float)
	{
		var tc:TimerComponent = cast e.get(Timer);
		tc.mark = tc.t + 1 + 2 * hxd.Math.random();
		e.removeComponent(Draw);
		e.addComponent(new DrawDisperseComponent(GFX.getDisperse(Lander)));		 
	}
	public function update(c:FSMComponent,e:Entity,dt:Float)
	{
		var tc:TimerComponent = cast e.get(Timer);
		var dr:DrawDisperseComponent = cast e.get(DrawDisperse);
		dr.disperse = dr.disperse+dt*60;

		if ( tc.t > tc.mark )
		{
			e.get(FSM).next_state = Lander(Search);
		}
	}
	public function exit(c:FSMComponent,e:Entity,dt:Float)
	{
		e.removeComponent(DrawDisperse);
		e.addComponent(new DrawComponent(GFX.getAnim(Lander)));	
	 
	}
}
 