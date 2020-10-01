package components.draw;

import format.gif.Data.ColorTable;
import h2d.Anim;
import h2d.Bitmap;
import ecs.IComponent;
import Enums;
import hxd.Math;

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