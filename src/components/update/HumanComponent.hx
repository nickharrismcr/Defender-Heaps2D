package components.update;
import ecs.IComponent;
import Enums;  

class HumanComponent implements IComponent
{
    public var type:ComponentType;
    public var lander:Null<Int>;

    public function new()
    {
        type=Human;
    }    
}