package states.npc.human;

import components.update.PosComponent;
import components.draw.DrawComponent;
import fsm.IState;
import ecs.Entity;
import fsm.FSMComponent;
import Enums;
import event.MessageCentre;
import event.events.FireBulletEvent;

class Walk implements IState
{
	public var state:States=Human(Walk);

	public function new() {}
	
	public function enter(c:FSMComponent,e:Entity,dt:Float)
	{
		e.addComponent(new DrawComponent(GFX.getAnim(Human)));	
		var pc:PosComponent = cast e.get(Pos);
		pc.x=Std.random(Std.int(Config.settings.world_width));
		pc.y=e.engine.app.s2d.height - e.engine.game.mountainAt(Std.int(pc.x)) ;
		pc.dy=0;
		pc.dx=0;
	}


	public function update(c:FSMComponent,e:Entity,dt:Float)
	{
		 
	 
	}

	public function exit(c:FSMComponent,e:Entity,dt:Float)
	{
	
	}

}
 