package states.npc.baiter;


import components.draw.DrawComponent;
import components.update.PosComponent;
import fsm.IState;
import ecs.Entity;
import fsm.FSMComponent;
import logging.Logging;
import Enums;
import components.update.TimerComponent;
import components.draw.DrawDisperseComponent;

class Materialize implements IState
{
	public var state:States=Baiter(Materialize);

	public function new() {}
	
	public function enter(c:FSMComponent,e:Entity,dt:Float)
	{
		var ddc = new DrawDisperseComponent(GFX.getDisperse(Baiter));
		ddc.disperse=120;
		e.addComponent(ddc);
		var pc:PosComponent = cast e.get(Pos);
		if (pc.x==0){
			pc.x=Std.random(e.engine.app.s2d.width)/2;
			pc.y=Std.random(e.engine.app.s2d.height)/2;
			Logging.trace('${e.id},${pc.x},${pc.y}');
		}
		pc.dx=Std.random(200)-100;
		pc.dy=Std.random(200)-100;		 
	}
	public function update(c:FSMComponent,e:Entity,dt:Float)
	{
	
		var dr:DrawDisperseComponent = cast e.get(DrawDisperse);
		dr.disperse = dr.disperse-dt*60;

		if ( dr.disperse <= 1.0 )
		{
			e.get(FSM).next_state = Baiter(Chase);
		}
	}
	public function exit(c:FSMComponent,e:Entity,dt:Float)
	{
		e.removeComponent(DrawDisperse);
		e.addComponent(new DrawComponent(GFX.getAnim(Baiter)));	
	}
}
 