package components.update;

import ecs.IComponent;
import Enums;

class CollideComponent implements IComponent
{
    public var type:ComponentType;
    
    public function new( )
    {
        type=Collide;
    }    
}