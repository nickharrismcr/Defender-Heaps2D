package components.draw;


import h2d.Anim;
import ecs.IComponent;
 
 ////@:build(macros.ComponentEnumMacro.build())   
class DrawComponent implements IComponent
{
    public var type = Draw;
    public var drawable:h2d.Anim;

    public function new(anim:h2d.Anim)
    {
        this.drawable=anim;
    }    
}