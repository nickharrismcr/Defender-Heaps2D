package states.player;



import components.update.PlayerComponent;
import fsm.IState;
import ecs.Entity;
import fsm.FSMComponent;

import components.update.TimerComponent;
import components.update.PosComponent;
import components.draw.DrawComponent;

class Play implements IState
{
	public var state:States=Player(Play);

	public function new() {}
	
	public function enter(c:FSMComponent,e:Entity,dt:Float)
	{
		var dc:DrawComponent = new DrawComponent(GFX.getAnim(Player));
		e.addComponent(dc);
		if ( ! e.has(Pos)){
			var pc = new PosComponent();
			pc.x=0;
			pc.y=e.engine.game.s2d.height/2;
			e.addComponent(pc);
			e.engine.game.player_pos = pc;
		}
		e.engine.game.freeze=false;
	}

	public function update(c:FSMComponent,e:Entity,dt:Float)
	{
		var pos:PosComponent = cast e.get(Pos);
		var pl:PlayerComponent = cast e.get(Player);
		this.handle_input(e,pos,pl,dt);
		Camera.position = pos.x - pl.camera_offset;
		
	}


	public function exit(c:FSMComponent,e:Entity,dt:Float)
	{ }

	private function handle_input(e:Entity,pos:PosComponent,pl:PlayerComponent,dt:Float)
	{
	 
		if ( hxd.Key.isDown( Config.keys.thrust )) {
			if ( Math.abs(pos.dx) < 1000 ){
				pos.dx += ( 500 * pl.direction * dt ) ;
			}
		} else {
			if ( Math.abs(pos.dx) > 0 ){
				pos.dx -= 400 * dt * ( pos.dx > 0 ? 1 : -1 );
			}
		}  

		pos.dy = 0;
		if ( hxd.Key.isDown( Config.keys.up )){
			if ( pos.y >  Config.settings.play_area_start ){
				pos.dy = -400;
			}
		} else if ( hxd.Key.isDown( Config.keys.down )){
			if ( pos.y < e.engine.game.s2d.height - 60) {
				pos.dy = 400;
			}
		}

		var offset_target =  ( pl.direction == 1 )  ? 200 : e.engine.game.s2d.width-200;
		pl.camera_offset += (  offset_target - pl.camera_offset  )/100;
		
		if ( hxd.Key.isDown( Config.keys.reverse )) {
			if (! pl.reverse_down ){
				pl.reverse_down = true;
				pl.direction = - pl.direction;
				pos.dx = 0;
			}
		} else {
			pl.reverse_down = false;
		}
		var dc:DrawComponent = cast e.get(Draw);
		dc.flip = ( pl.direction == 1 )? false : true;
	}
}
 