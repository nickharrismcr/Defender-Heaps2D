package components.update;

import ecs.IComponent;
 

//@:build(macros.ComponentEnumMacro.build()) 
class PosComponent implements IComponent
{
    public var type = Pos;
    public var x:Float;
    public var y:Float;
    public var dx:Float;
    public var dy:Float;

    public function new()
    { 
        x=0;
        y=0;
        dx=Std.random(100)-100;
        dy=Std.random(100)-100;
    }    
}