package components.update;


import ecs.IComponent;

////@:build(macros.ComponentEnumMacro.build())  
class LaserComponent implements IComponent
{
    public var type = Laser;
    public var dir:Int;
    public var length:Float;
    public var color:h3d.Vector;
    public var gaps:Array<Array<Int>>;
    public var bounds:h2d.col.Bounds;

    public function new()
    {
        this.gaps = new Array<Array<Int>>();
        this.bounds = new h2d.col.Bounds();
    }    
}