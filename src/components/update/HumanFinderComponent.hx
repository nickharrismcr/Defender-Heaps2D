package components.update;
import ecs.IComponent;


////@:build(macros.ComponentEnumMacro.build()) 
class HumanFinderComponent implements IComponent
{
    public var type = HumanFinder;
    public var target_id:Null<Int>;
    public function new()
    {}    
}