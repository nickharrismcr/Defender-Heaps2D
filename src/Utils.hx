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

    public static function getBulletVector(x:Float,y:Float,targx:Float,targy:Float,time:Float)
    {
        var dx = (targx-x)/time;
        var dy = (targy-y)/time;
        return {x:dx,y:dy};
    }
}