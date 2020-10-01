package components.update;

import ecs.IComponent;
import Enums;

class PosComponent implements IComponent
{
    public var type:ComponentType;
    public var x:Float;
    public var y:Float;
    public var dx:Float;
    public var dy:Float;

    public function new()
    {
        type=Pos;
        x=0;
        y=0;
        dx=Std.random(100)-100;
        dy=Std.random(100)-100;
    }    
}