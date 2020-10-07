package components.draw;


import h2d.Anim;
import ecs.IComponent;

// @:build(macros.ComponentEnumMacro.build()) 

class DrawComponent implements IComponent
{
    public var type:ComponentType = Draw;
    public var drawable:h2d.Anim;
    public var text:h2d.Text;
    public var flip:Bool;

    public function new(anim:h2d.Anim)
    {
        this.drawable=anim;
        var font : h2d.Font = hxd.res.DefaultFont.get();
        this.text = new h2d.Text(font);
        this.flip = false;
    }    
}