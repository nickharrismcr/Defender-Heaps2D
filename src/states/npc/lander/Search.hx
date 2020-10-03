package states.npc.lander;

import components.update.ShootableComponent;
import event.events.FireBulletEvent;
import components.update.PosComponent;
import fsm.IState;
import ecs.Entity;
import fsm.FSMComponent;
import components.update.TimerComponent;
import logging.Logging;
import Enums;
import event.MessageCentre;
import Planet;

class Search implements IState
{
	public var state:States=Lander(Search);

	public function new() {}
	
	public function enter(c:FSMComponent,e:Entity,dt:Float)
	{
		e.addComponent(new ShootableComponent());
		var pc:PosComponent = cast e.get(Pos);
		pc.dx=Std.random(200);
		if ( Std.random(2)==1) pc.dx = -pc.dx;
		pc.dy=80;
	}


	public function update(c:FSMComponent,e:Entity,dt:Float)
	{
		var pc:PosComponent = cast e.get(Pos);
		pc.x=pc.x+pc.dx*dt;
		pc.y=pc.y+pc.dy*dt;

		var m = e.engine.game.mountainAt(Std.int(pc.x)); 
		var wh = e.engine.app.s2d.height;

		if ( pc.y > wh - ( m + 100 ))
		{
			pc.dy = -50; 
		}
		if ( pc.y < wh - ( m + 100 ))
		{
			pc.dy = 50;
		}

	}

	public function exit(c:FSMComponent,e:Entity,dt:Float)
	{
	
	}

}
 