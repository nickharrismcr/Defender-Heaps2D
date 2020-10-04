package components.update;

import ecs.IComponent;


//@:build(macros.ComponentEnumMacro.build()) 
class DeadlyComponent implements IComponent
{ 
    public var type = Deadly;
    public function new()
    {}    
}