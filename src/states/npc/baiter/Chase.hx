package states.npc.baiter;

import components.update.PosComponent;
import fsm.IState;
import ecs.Entity;
import fsm.FSMComponent;
import components.update.TimerComponent;
import logging.Logging;
import Enums;
import event.MessageCentre;
import event.events.FireBulletEvent;

class Chase implements IState
{
	public var state:States=Baiter(Chase);

	public function new() {}
	
	public function enter(c:FSMComponent,e:Entity,dt:Float)
	{
		
	 
	}


	public function update(c:FSMComponent,e:Entity,dt:Float)
	{
		var pc:PosComponent = cast e.get(Pos);
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
		if ( Std.random(200) < 2 ){
			
			for ( oe in e.engine.getEntitiesWithComponent(Shootable))
			{
				if ( oe.id != e.id ){
					var opc:PosComponent = cast oe.get(Pos);
					MessageCentre.notify(new FireBulletEvent(e,pc,opc ));
				}
				break;
			}
		}
	 
	}

	public function exit(c:FSMComponent,e:Entity,dt:Float)
	{
	
	}

}
 