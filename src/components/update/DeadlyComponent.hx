package components.update;

import ecs.IComponent;
import Enums;

class DeadlyComponent implements IComponent
{
    public var type:ComponentType;
    public function new()
    {
        type=Deadly;
    }    
}