package states.npc.baiter;

import components.update.ShootableComponent;
import format.swf.Constants.TagId;
import components.update.PosComponent;
import fsm.IState;
import ecs.Entity;
import fsm.FSMComponent;
import components.update.TimerComponent;



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
		c.scratch=-1;	
		var tc:TimerComponent = cast e.get(Timer);
		tc.mark = tc.t + 1;
	}


	public function update(c:FSMComponent,e:Entity,dt:Float)
	{	
		if ( c.scratch == -1 ){
			for ( oe in e.engine.getEntitiesWithComponent(Shootable))
			{
				if ( oe.id != e.id ){
					c.scratch = oe.id;
					break;
				}
			}
		}
		
		var oe = e.engine.getEntity(c.scratch);
		if ( oe == null ) {
			 c.scratch = -1;
			 return;
		}
		if ( ! oe.has(Shootable)){
			c.scratch = -1;
			 return;
		}

		var pc:PosComponent = cast e.get(Pos);
		var opc:PosComponent = cast oe.get(Pos);
		if ( Std.random(100) < 3 ){
			if ( Math.abs(pc.x-opc.x ) < e.engine.game.s2d.width ) { 
				MessageCentre.notify(new FireBulletEvent(e,pc,opc ));
			}
		}
		
		var tc:TimerComponent = cast e.get(Timer);
		if ( tc.t > tc.mark ){
			
			pc.dx = 800 * ( pc.x > opc.x ? -1 : 1 ) ;
			pc.dy = 80 * ( (pc.y > opc.y) ? -1 : 1 ) ; 
			tc.mark = tc.t+0.5; 
		}

		Camera.position += ((pc.x-e.engine.game.s2d.width/2)-Camera.position)/100;		
	}

	public function exit(c:FSMComponent,e:Entity,dt:Float)
	{
	
	}

}
 