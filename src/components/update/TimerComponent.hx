package components.update;
import ecs.IComponent;
import Enums;  

class TimerComponent implements IComponent
{
    public var type:ComponentType;
    public var t:Float;
    public var mark:Float;

    public function new()
    {
        type=Timer;
        t=0;
        mark=0;
    }    
}