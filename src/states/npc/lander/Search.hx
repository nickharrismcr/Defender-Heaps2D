package states.npc.lander;

import components.update.HumanComponent;
import components.update.ShootableComponent;
import event.events.FireBulletEvent;
import components.update.PosComponent;
import components.update.HumanFinderComponent;
import fsm.IState;
import ecs.Entity;
import fsm.FSMComponent;

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
		var fc:HumanFinderComponent = cast e.get(HumanFinder);
		this.find_human(e,fc);
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
		var fc:HumanFinderComponent = cast e.get(HumanFinder);
		if ( fc.target_id == null){
			if ( e.engine.getEntity(fc.target_id) == null ) this.find_human(e,fc);
		}
		var te = e.engine.getEntity(fc.target_id);
		var tp:PosComponent = cast te.get(Pos);
		if ( Math.abs(tp.x - pc.x ) < 30 ){
			c.next_state = Lander(Pounce);
		}
	}

	public function exit(c:FSMComponent,e:Entity,dt:Float)
	{
	
	}

	private function find_human(e:Entity,fc:HumanFinderComponent)
	{
 
		for ( he in e.engine.getEntitiesWithComponent(Human) ) 
		{
			var hc:HumanComponent = cast he.get(Human);
			if ( hc.lander == null ){
				hc.lander = e.id;
				fc.target_id = he.id;
				break;
			}
		}
	}
 
		

}
 