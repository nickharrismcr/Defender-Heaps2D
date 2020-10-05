package components.update;
import ecs.IComponent;
 

//@:build(macros.ComponentEnumMacro.build()) 
class HumanComponent implements IComponent
{
    public var type = Human;
    public var lander:Null<Int>;
    public var dropped_height:Int;

    public function new()
    {  }    
}