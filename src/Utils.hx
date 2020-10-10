import haxe.ds.Vector;
import components.update.CollideComponent;
import components.update.PosComponent;

class Utils {

	public static var red = new h3d.Vector(1, 0, 0, 1);
	public static var green = new h3d.Vector(0, 1, 0, 1);
	public static var blue = new h3d.Vector(0, 0, 1, 1);
	public static var yellow = new h3d.Vector(1, 1, 0, 1);

	public static function clamp(v:Float, min:Float, max:Float):Float {
		if (v < min)
			return min;
		if (v > max)
			return max;
		return v;
	}

	public static function rand_col():h3d.Vector {
		var r = hxd.Math.random();
		var g = hxd.Math.random();
		var b = hxd.Math.random();
		return new h3d.Vector(r, g, b, 1);
	}

	public static function random(from:Int, to:Int):Int {
		return from + Std.random(to - from);
	}

	public static function getBulletVector(firer:PosComponent, target:PosComponent, time:Float) {
		var projected_x:Float = target.x + (target.dx * time);
		var projected_y:Float = target.y + (target.dy * time);
		var dx = (projected_x - firer.x) / time;
		var dy = (projected_y - firer.y) / time;
		return {x: dx, y: dy};
	}

	public static function getColorCycleGenerator(time:Float):(h3d.Vector,Float)->Void {

		var col_list:Array<h3d.Vector> = [Utils.red,Utils.green,Utils.blue,Utils.yellow];
		var ind:Int = 1;
		var col = new h3d.Vector(1, 0, 0, 0);
		var nextcol = new h3d.Vector(0, 0, 0, 0);
		var dr:Float = 0;
        var dg:Float = 0;
        var db:Float = 0;
		var tc:Float = 0;

		function _closure(incol:h3d.Vector, dt:Float) {
			tc = tc + dt;
			col.r = Utils.clamp(col.r + dr * dt, 0, 1);
			col.g = Utils.clamp(col.g + dg * dt, 0, 1);
			col.b = Utils.clamp(col.b + db * dt, 0, 1);
			if (tc >= time) {
				tc = 0;
				nextcol = col_list[ind % 4];
				ind = ind + 1;
				dr = (nextcol.r - col.r) / time;
				dg = (nextcol.g - col.g) / time;
				db = (nextcol.b - col.b) / time;
			}
			incol.r = col.r;
			incol.g = col.g;
			incol.b = col.b;
        }
        return _closure;
	}
}
