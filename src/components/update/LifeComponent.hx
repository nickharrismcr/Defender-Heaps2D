package components.update;
import ecs.IComponent;


//@:build(macros.ComponentEnumMacro.build()) 
class LifeComponent implements IComponent
{
    public var type = Life;
    public var t:Float;
    public var life:Float;

    public function new(life:Float)
    {
        this.t=0;
        this.life=life;
    }    
}