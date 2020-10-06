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
    public var kill_off_screen:Bool;

    public function new()
    { 
        x=0;
        y=0;
        dx=0;
        dy=0;
        kill_off_screen=false;
    }    
}