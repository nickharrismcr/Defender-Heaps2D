package components.update;

import ecs.IComponent;
import Enums;

class StarComponent implements IComponent
{
    public var type:ComponentType;
    public var col:h3d.Vector;
    public var bmp:h2d.Bitmap;

    public function new()
    {
        type=Star;
    }    
}