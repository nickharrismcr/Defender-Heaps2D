 

class Camera
{
    public static var position:Float;

    public static function setPosition(pos:Float)
    {
        Camera.position=pos;
        var ww = Config.settings.world_width;
        if ( Camera.position < 0) Camera.position += ww ;
        if ( Camera.position > ww ) Camera.position -= ww;
    }
}