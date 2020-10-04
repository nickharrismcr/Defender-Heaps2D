package components.update;
import ecs.IComponent;
 

//@:build(macros.ComponentEnumMacro.build()) 
class HumanComponent implements IComponent
{
    public var type = Human;
    public var lander:Null<Int>;

    public function new()
    {  }    
}