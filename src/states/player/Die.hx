package states.player;
 
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
		 e.removeComponent(Player);
		 e.addComponent( new DrawComponent(GFX.getAnim(PlayerDie)));
		 var tc:TimerComponent = cast e.get(Timer);
		 tc.mark = tc.t + 2;
		 var pos:PosComponent = cast e.get(Pos);
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
 