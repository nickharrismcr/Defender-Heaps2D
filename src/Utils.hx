import logging.Logging;
import components.update.CollideComponent;
import components.update.PosComponent;


class Utils
{

    public static function rand_col():h3d.Vector
    {
       var r = hxd.Math.random();
       var g = hxd.Math.random();
       var b = hxd.Math.random();
       return new h3d.Vector(r,g,b,1);
    }

    public static function getBulletVector(firer:PosComponent,target:PosComponent,time:Float)
    {
        var projected_x:Float = target.x + (target.dx*time);
        var projected_y:Float = target.y + (target.dy*time);
        var dx = (projected_x-firer.x)/time;
        var dy = (projected_y-firer.y)/time;
        return {x:dx,y:dy};
    }
}