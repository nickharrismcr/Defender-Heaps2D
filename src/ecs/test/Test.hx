package ecs.test;

import logging.Logging;
import ecs.Entity;
import ecs.Filter;
import ecs.Component;
import ecs.System;
import ecs.Engine;

class MoveComponent extends Component	
{
    public function new () super();
	public var m="move";
}

class PosComponent extends Component	
{
	public function new () super();
	public var p="pos";
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
            var m=e.get(MoveComponent).m;
            var id=e.id;
            trace ('move $id $m');
		}
	}
}

class PosSystem implements ISystem extends System
{
	public function new():Void
	{
		super();
		this.filter=new Filter();
		this.filter.add(PosComponent);
	}	

	public override function update(dt:Float):Void
	{
		for ( e in this.targets )
		{
            var p=e.get(PosComponent).p;
            var id=e.id;
            trace ('pos $id $p');
		}
	}
}

class MovePosSystem implements ISystem extends System
{
	public function new():Void
	{
		super();
		this.filter=new Filter();
		this.filter.add([MoveComponent,PosComponent]);
	}	

	public override function update(dt:Float):Void
	{
		for ( e in this.targets )
		{
            var m=e.get(MoveComponent).m;
            var p=e.get(PosComponent).p;
            var id=e.id;
            trace ('movepos $id $m $p');
    
		}
	}
}

class Test {

	public static function run():Void
	{
        var eng=new Engine();
		var msys=new MoveSystem();
		var psys=new PosSystem();
        var mpsys=new MovePosSystem();
        eng.addUpdateSystem(msys);
		eng.addUpdateSystem(mpsys);
		eng.addUpdateSystem(psys);

        var me=new Entity();
		me.addComponent(new MoveComponent());
		eng.addEntity(me);
        eng.update(0);

        var pe=new Entity();
		pe.addComponent(new PosComponent());
		eng.addEntity(pe);
        eng.update(0);

        me.addComponent(new PosComponent());
        eng.update(0);
        
	}
}
