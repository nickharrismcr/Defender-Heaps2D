package states.npc.human;


import components.draw.DrawComponent;
import fsm.IState;
import ecs.Entity;
import fsm.FSMComponent;
import logging.Logging;
import Enums;
import components.update.TimerComponent;
import components.draw.DrawDisperseComponent;

class Grabbed implements IState
{
	public var state:States=Human(Grabbed);

	public function new() {}
	
	public function enter(c:FSMComponent,e:Entity,dt:Float)
	{
		var tc:TimerComponent = cast e.get(Timer);
		tc.mark = tc.t + 1 + 2 * hxd.Math.random();
		e.removeComponent(Draw);
		e.removeComponent(Shootable);
		e.addComponent(new DrawDisperseComponent(GFX.getDisperse(Human)));		 
	}
	public function update(c:FSMComponent,e:Entity,dt:Float)
	{
		var tc:TimerComponent = cast e.get(Timer);
		var dr:DrawDisperseComponent = cast e.get(DrawDisperse);
		dr.disperse = dr.disperse+dt*60;
		if ( dr.disperse > 120 ) e.engine.removeEntity(e);

	}
	public function exit(c:FSMComponent,e:Entity,dt:Float)
	{
		e.removeComponent(DrawDisperse);
	}
}
 