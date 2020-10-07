package states.player;
 
import fsm.IState;
import ecs.Entity;
import fsm.FSMComponent;


import components.update.TimerComponent;
import components.update.PosComponent;
import components.draw.DrawComponent;
import components.draw.DrawDisperseComponent;

class Materialize implements IState
{
	public var state:States=Player(Materialize);

	public function new() {}
	
	public function enter(c:FSMComponent,e:Entity,dt:Float)
	{
		var pc:PosComponent = cast e.get(Pos);
		pc.x=Std.random(Config.settings.world_width);
		pc.y=Config.settings.play_area_start + Std.random(200);
	
		var ddc = new DrawDisperseComponent(GFX.getDisperse(Player));
		ddc.disperse = 120;	
		e.addComponent(ddc);	 
	}

	public function update(c:FSMComponent,e:Entity,dt:Float)
	{
		var tc:TimerComponent = cast e.get(Timer);
		var dr:DrawDisperseComponent = cast e.get(DrawDisperse);
		dr.disperse = dr.disperse-dt*60;

		if ( dr.disperse <= 1 ) 
		{
			c.next_state = Lander(Search);
		}
	}
	public function exit(c:FSMComponent,e:Entity,dt:Float)
	{
		 
		e.removeComponent(DrawDisperse);
		e.addComponent(new DrawComponent(GFX.getAnim(Player)));	
	}
}
 