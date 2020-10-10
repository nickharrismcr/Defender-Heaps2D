package states.player;
 
import components.update.PlayerComponent;
import fsm.IState;
import ecs.Entity;
import fsm.FSMComponent;


import components.update.TimerComponent;
import components.update.PosComponent;
import components.draw.DrawComponent;
 

class Die implements IState
{
	public var state:States=Player(Die);

	public function new() {}
	
	public function enter(c:FSMComponent,e:Entity,dt:Float)
	{
		 e.removeComponent(Draw);
		 var pos:PosComponent = cast e.get(Pos);
		 var dc = new DrawComponent(GFX.getAnim(PlayerDie));
		 dc.flip = ( pos.direction == 1 )? false : true;
		 e.addComponent(dc);
		 e.removeComponent(Player);
		 var tc:TimerComponent = cast e.get(Timer);
		 tc.mark = tc.t + 2;
		 
		 pos.dx = 0;
		 pos.dy = 0;

		 e.engine.game.freeze=true;
	}

	public function update(c:FSMComponent,e:Entity,dt:Float)
	{
		var tc:TimerComponent = cast e.get(Timer);
		if ( tc.t > tc.mark ){
			c.next_state = Player(Explode);
		}
	}

	public function exit(c:FSMComponent,e:Entity,dt:Float)
	{
		 
	}
}
 