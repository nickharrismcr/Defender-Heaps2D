package components.update;
import ecs.IComponent;
import Enums;  

class HumanFinderComponent implements IComponent
{
    public var type:ComponentType;
    public var target_id:Null<Int>;

    public function new()
    {
        type=HumanFinder;
    }    
}