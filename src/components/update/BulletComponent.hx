package components.update;


import ecs.IComponent;

////@:build(macros.ComponentEnumMacro.build())  
class BulletComponent implements IComponent
{
    public var type = Bullet;
    public function new()
    {}    
}