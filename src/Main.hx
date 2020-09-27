import logging.Logging;
import ecs.Entity;
import ecs.Filter;
import ecs.Component;
import ecs.System;
import ecs.Engine;

class MoveComponent extends Component	
{
	public var x=0;
	public var y=0;

	public function new()
	{
		super();
	}
}
class DrawComponent extends Component	
{
	public var x=0;
	public var y=0;
	public function new()
	{
		super();
	}
}
class MoveSystem implements ISystem extends System
{
	public function new():Void
	{
		super();
		this.filter=new Filter();
		this.filter.add(MoveComponent);
	}	
	public override function update(dt:Float):Void
	{
		for ( e in this.targets )
		{
			var c=e.get(MoveComponent);
			trace(c.x);
			trace(c.y);
			var c=e.get(DrawComponent);
		}
	}
}


class Main {

	public static function main():Void
	{
		var logger=Logging.get();
		Logging.level=DEBUG;
		logger.debug("hello");

		var sys=new MoveSystem();
		var ent=new Entity();
		ent.addComponent(new MoveComponent());
		var eng=new Engine();
		eng.addUpdateSystem(sys);
		eng.addEntity(ent);
		eng.update(0);
	}
}











