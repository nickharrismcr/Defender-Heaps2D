 

class Camera
{
    public static var position:Float;

    public static function update()
    {
        if ( Camera.position < 0) Camera.position += Config.settings.world_width;
        if ( Camera.position > Config.settings.world_width ) Camera.position -= Config.settings.world_width;
    }
}