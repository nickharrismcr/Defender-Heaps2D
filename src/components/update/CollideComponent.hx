package components.update;

import ecs.IComponent;


////@:build(macros.ComponentEnumMacro.build()) 
class CollideComponent implements IComponent
{
    public var type = Collide;
    public function new( )
    {}    
}