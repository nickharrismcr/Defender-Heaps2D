package states.npc.baiter;

import components.update.PosComponent;
import fsm.IState;
import ecs.Entity;
import fsm.FSMComponent;
import components.update.TimerComponent;
import logging.Logging;
import Enums;

class Chase implements IState
{
	public var state:States=Baiter(Chase);

	public function new() {}
	
	public function enter(c:FSMComponent,e:Entity,dt:Float)
	{
		var pc:PosComponent = cast e.get(Pos);
		if (pc.x==0){
			pc.x=Std.random(e.engine.app.s2d.width)/2;
			pc.y=Std.random(e.engine.app.s2d.height)/2;
			Logging.trace('${e.id},${pc.x},${pc.y}');
		}
		pc.dx=Std.random(200)-100;
		pc.dy=Std.random(200)-100;
		var tc:TimerComponent = cast e.get(Timer);
		tc.mark=tc.t + 4 + hxd.Math.random(4);
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
 