package components.update;

import ecs.IComponent;


//@:build(macros.ComponentEnumMacro.build()) 
class ShootableComponent implements IComponent
{
    public var type = Shootable;
    public function new()
    {}    
}