package components.update;


import ecs.IComponent;

////@:build(macros.ComponentEnumMacro.build())  
class LaserComponent implements IComponent
{
    public var type = Laser;
    public function new()
    {}    
}