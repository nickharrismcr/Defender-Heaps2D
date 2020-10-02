package components.draw;


import h2d.Anim;
import ecs.IComponent;
import Enums;

class DrawComponent implements IComponent
{
    public var type:ComponentType;
    public var drawable:h2d.Anim;

    public function new(anim:h2d.Anim)
    {
        this.drawable=anim;
        type=Draw;
    }    
}