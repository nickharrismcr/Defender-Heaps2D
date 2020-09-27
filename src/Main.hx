import logging.Logging;
import ecs.Entity;
import ecs.Filter;
import ecs.Component;
import ecs.System;

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
	{}
}


class Main {

	public static function main():Void
	{
		var logger=Logging.get();
		Logging.level=DEBUG;
		logger.debug("hello");

		var sys=new MoveSystem();
		var ent=new Entity();
		ent.addComponent(new DrawComponent());
		sys.addEntity(ent);
	}
}











