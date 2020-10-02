package components.update;

import ecs.IComponent;
import Enums;

class BulletComponent implements IComponent
{
    public var type:ComponentType;
    public function new()
    {
        type=Bullet;
    }    
}