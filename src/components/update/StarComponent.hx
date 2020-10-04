package components.update;

import ecs.IComponent;



////@:build(macros.ComponentEnumMacro.build()) 
class StarComponent implements IComponent
{
    public var type = Star;
    public var col:h3d.Vector;
    public var bmp:h2d.Bitmap;
    
    public function new()
    {  }    
}
 