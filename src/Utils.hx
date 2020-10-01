
class Utils
{

    public static function rand_col():h3d.Vector
    {
        return new h3d.Vector(
            hxd.Math.random(),
            hxd.Math.random(),
            hxd.Math.random(),
            1
        );
    }
}