package components.update;

import ecs.IComponent;
import Enums;

class DrawComponent implements IComponent
{
    public var type:ComponentType;

    public function new()
    {
        type=Draw;
    
    }    
}