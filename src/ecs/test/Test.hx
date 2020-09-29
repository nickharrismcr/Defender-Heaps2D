package ecs.test;

import logging.Logging;
import ecs.Entity;
import ecs.Filter;
import ecs.Component;
import ecs.System;
import ecs.Engine;
import ecs.Enums;

class MoveComponent implements IComponent	
{
    public var type=Move;
	public var m="moveval";
	public function new() {}
}

class PosComponent implements IComponent	
{
	public var type=Pos;
	public var p="posval";
	public function new() {}
}


class MoveSystem implements ISystem extends System
{
	public function new():Void
	{
		super();
		this.filter=new Filter();
		this.filter.add(Move);
		this.type=Move;
	}	

	public override function update(dt:Float):Void
	{
		for ( e in this.targets )
		{
            var mm=e.get(Move).m;
            var id=e.id;
            Logging.trace ('${this.type} system update E $id move:$mm');
		}
	}
}

class PosSystem implements ISystem extends System
{
	public function new():Void
	{
		super();
		this.filter=new Filter();
		this.filter.add(Pos);
		this.type=Pos;
	}	

	public override function update(dt:Float):Void
	{
		for ( e in this.targets )
		{
            var p=e.get(Pos).p;
            var id=e.id;
            Logging.trace ('${this.type} system update E $id pos:$p');
		}
	}
}

class MovePosSystem implements ISystem extends System
{
	public function new():Void
	{
		super();
		this.filter=new Filter();
		this.filter.add([Move,Pos]);
		this.type=MovePos;
	}	

	public override function update(dt:Float):Void
	{
		for ( e in this.targets )
		{
            var m=e.get(Move).m; 
            var p=e.get(Pos).p;
            var id=e.id;
            Logging.trace ('${this.type} system update : E $id move:$m pos:$p');
    
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
		
		me.deactivate();
		eng.update(0);
		me.activate();
		eng.update(0);
        
	}
}
