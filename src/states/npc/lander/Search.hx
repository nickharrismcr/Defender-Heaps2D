package states.npc.lander;

import event.events.FireBulletEvent;
import components.update.PosComponent;
import fsm.IState;
import ecs.Entity;
import fsm.FSMComponent;
import components.update.TimerComponent;
import logging.Logging;
import Enums;
import event.MessageCentre;

class Search implements IState
{
	public var state:States=Lander(Search);

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
		tc.mark=tc.t + 8 + hxd.Math.random(8);
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

		if ( Std.random(1000) < 2 ){
			var tx = Std.random(e.engine.app.s2d.width);
			var ty = Std.random(e.engine.app.s2d.height);
			MessageCentre.notify(new FireBulletEvent(e,pc.x,pc.y, tx,ty ));
		}
		
		 
	}

	public function exit(c:FSMComponent,e:Entity,dt:Float)
	{
	
	}

}
 