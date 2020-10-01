package states;


import components.update.PosComponent;
import fsm.IState;
import ecs.Entity;
import fsm.FSMComponent;
import components.update.TimerComponent;
import logging.Logging;
import Enums;

class TestMove implements IState
{
	public var state:States=TestMove;

	public function new() {}
	
	public function enter(c:FSMComponent,e:Entity,dt:Float)
	{
		var pc:PosComponent = cast e.get(Pos);
		if (pc.x==0){
			pc.x=Std.random(e.engine.app.s2d.width);
			pc.y=Std.random(e.engine.app.s2d.height);
		}
		pc.dx=Std.random(200)-100;
		pc.dy=Std.random(200)-100;
		var tc:TimerComponent = cast e.get(Timer);
		tc.mark=tc.t + hxd.Math.random();
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
		
		var tc:TimerComponent = cast e.get(Timer);

		if ( tc.t > tc.mark ) 
		{
			e.get(FSM).next_state = TestStop;
		}
	}
	public function exit(c:FSMComponent,e:Entity,dt:Float)
	{}
}
 