package components.update;
import ecs.IComponent;


//@:build(macros.ComponentEnumMacro.build()) 
class PlayerComponent implements IComponent
{
    public var type = Player;
    public var camera_offset:Float;
    public var reverse_down:Bool;
    public var fire_down:Bool;

    public function new()
    {
 
        this.camera_offset = 200;
        this.reverse_down = false;
        this.fire_down = false;
    }    
}