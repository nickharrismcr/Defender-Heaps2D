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
		var pc:PosComponent = cast e.get(Pos);
		pc.dx=Std.random(400);
		pc.dy=Std.random(200)-100;		
	}


	public function update(c:FSMComponent,e:Entity,dt:Float)
	{
		var pc:PosComponent = cast e.get(Pos);
		pc.x=pc.x+pc.dx*dt;
		pc.y=pc.y+pc.dy*dt;
		 
		 
		Camera.position += ((pc.x-500)-Camera.position)/100;

		if ( Std.random(80) < 2 ){
			
			for ( oe in e.engine.getEntitiesWithComponent(Shootable))
			{
				if ( oe.id != e.id ){
					var opc:PosComponent = cast oe.get(Pos);
					if ( Math.abs(pc.x-opc.x ) < e.engine.app.s2d.width ) { 
						MessageCentre.notify(new FireBulletEvent(e,pc,opc ));
					}
					pc.dx = 800 * ( pc.x > opc.x ? -1 : 1) ;
					pc.dy = 80 * ( (pc.y > opc.y-300) ? -1 : 1) ;  
					break;
				}
				
			}
		}
	 
	}

	public function exit(c:FSMComponent,e:Entity,dt:Float)
	{
	
	}

}
 