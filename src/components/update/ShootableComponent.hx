package components.update;

import ecs.IComponent;
import Enums;

class ShootableComponent implements IComponent
{
    public var type:ComponentType;
    public function new()
    {
        type=Shootable;
    }    
}