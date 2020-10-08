package states.player;
 
import event.events.PlayerExplode.PlayerExplodeEvent;
import fsm.IState;
import ecs.Entity;
import fsm.FSMComponent;


import components.update.TimerComponent;
import components.update.PosComponent;
import components.draw.DrawComponent;
import components.draw.DrawDisperseComponent;

class Explode implements IState
{
	public var state:States=Player(Explode);

	public function new() {}
	
	public function enter(c:FSMComponent,e:Entity,dt:Float)
	{
		e.removeComponent(Draw);
		MessageCentre.notify(new PlayerExplodeEvent(e));
		var tc:TimerComponent = cast e.get(Timer);
		tc.mark = tc.t + 4;
	}

	public function update(c:FSMComponent,e:Entity,dt:Float)
	{
		var tc:TimerComponent = cast e.get(Timer);
		if (tc.t > tc.mark){
			c.next_state = Player(Play);
		}
	}
	public function exit(c:FSMComponent,e:Entity,dt:Float)
	{
		 
		 
	}
}
 