 
import hxd.Window.DisplayMode;
import h3d.Vector;
import logging.Logging;
import test.Test;
import hxd.Math;

class Box
{
	public var bmp:h2d.Bitmap;
	public var dx:Float;
	public var dy:Float;

	public function new(s2d:h2d.Scene,tile:h2d.Tile, x:Int,y:Int, dx_:Float,dy_:Float)
	{
		this.bmp = new h2d.Bitmap(tile, s2d);
 
		this.bmp.x = x;
		this.bmp.y = y;
		this.dx=dx_;
		this.dy=dy_;
		var r=Math.random();
		var g=Math.random();
		var b=Math.random();
		this.bmp.color=new Vector(r,g,b);
	}
}

class Main extends hxd.App {

	var boxes : Array<Box>;
	var tf:h2d.Text;
	var tf2:h2d.Text;
	var win:hxd.Window;
	var c:Int;
	var max:Int;
	var tile:h2d.Tile;

	override function init() {

		win=hxd.Window.getInstance();
		win.displayMode=Fullscreen;
	
		boxes=new Array<Box>();
		max=15000;
		tile = h2d.Tile.fromColor(0xFFFFFF, 1, 1);
		c=10;	
		tf = new h2d.Text(hxd.res.DefaultFont.get(), s2d);
	}
	// on each frame
	override function update(dt:Float) {

		c--;
		if (c==0){
			for ( c in 1...max )
			{
				var box = new Box(s2d, this.tile,Std.random(this.win.width),Std.random(this.win.height),
												Std.random(100)-100,Std.random(100)-100);
				this.boxes.push(box);
			}
			 
		}
		for ( box in boxes )
		{
			box.bmp.x+=box.dx*dt;
			box.bmp.y+=box.dy*dt;

			if (box.bmp.x < 0 || box.bmp.x > this.win.width )  box.dx = -box.dx ;
			if (box.bmp.y < 0 || box.bmp.y > this.win.height )  box.dy = -box.dy ;
		}
		var fps:Int=cast 1/dt;
		tf.text='$fps';
 
		
	}

	static function main() {
		new Main();
	}
}







