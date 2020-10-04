package components.update;
import ecs.IComponent;


//@:build(macros.ComponentEnumMacro.build()) 
class TimerComponent implements IComponent
{
    public var type = Timer;
    public var t:Float;
    public var mark:Float;

    public function new()
    {
        t=0;
        mark=0;
    }    
}