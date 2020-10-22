package systems;

import components.draw.DrawDisperseComponent;
import components.update.PosComponent;
import ecs.System;
import ecs.Filter;
import ecs.Entity;



import Camera;

class DrawDisperseSystem extends System implements ISystem
{
	public function new( )
	{
		super( );
		this.type=DrawDisperseSystem;
		this.filter=new Filter();
		filter.add(DrawDisperse); 
		filter.add(Pos);
	}

	public override function onAddEntity(e:Entity)
	{
		Logging.trace('DrawDisperse system onAddEntity $e');
		var pos:PosComponent = cast e.get(Pos);
		var comp:DrawDisperseComponent = cast e.get(DrawDisperse);
		var xp = comp.tiles.xpixels;
		var yp = comp.tiles.ypixels; 
		var ps = comp.tiles.pixsize;

		for ( y in 0...yp ){
			for ( x in 0...xp ) {
				var bmp = comp.drawables[x][y];
				var xpos = pos.x + ((x - (xp/2))* ps * comp.disperse );
				var ypos = pos.y + ((y - (yp/2)) * ps * comp.disperse );
				bmp.setPosition(xpos,ypos);
				bmp.setScale(1.5);
				this.engine.game.s2d.addChild(bmp);
			}
		}
	}

	public override function onRemoveEntity(e:Entity)
	{
        Logging.trace('DrawDisperse system onRemoveEntity $e');
		var comp:DrawDisperseComponent = cast e.get(DrawDisperse);
		var xp = comp.tiles.xpixels;
		var yp = comp.tiles.ypixels; 
		

		for ( y in 0...yp ){
			for ( x in 0...xp ) {
				var bmp = comp.drawables[x][y];
				this.engine.game.s2d.removeChild(bmp);
			}
		}
	}

	public override function update(dt:Float)
	{
		for ( e in this.targets )
		{
			var pos:PosComponent = cast e.get(Pos);
			var comp:DrawDisperseComponent = cast e.get(DrawDisperse);
			var xp = comp.tiles.xpixels;
			var yp = comp.tiles.ypixels; 
			var ps = comp.tiles.pixsize;
	
			for ( y in 0...yp ){
				for ( x in 0...xp ) {
					var bmp = comp.drawables[x][y];
					var xpos = pos.screen_x + ((x - (xp/2))* ps * comp.disperse );
					var ypos = pos.y + ((y - (yp/2)) * ps * comp.disperse );
					bmp.setPosition(xpos,ypos);
				}
			}
		}
	}

	public function onEvent(ev:IEvent)
	{
		Logging.trace('DrawDisperse system got event ${ev.entity.id}');
	}
}