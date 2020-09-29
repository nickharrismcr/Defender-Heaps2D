package ecs;

import ecs.Entity;
import ecs.Engine;
import ecs.IComponent;
import ecs.Enums;
import logging.Logging;

interface ISystem { 

	public var type:SystemType;
	public function update(dt:Float):Void;
	private var filter:Filter;
}

class System implements ISystem  { 

	public var active:Bool;
	public var type:SystemType;
	
	private var filter:Filter;
	private var targets:Map<Int,Entity>;

	public function new() 
	{
		this.targets=new Map<Int,Entity>();
	}

	public function needsComponent(c:ComponentType):Bool
	{
		return this.filter.needsComponent(c);
	}

	@:allow(ecs.Engine)
	private function addEntityIfReqd(e:Entity):Void
	{
		var components = e.getComponents();
		for ( c in this.filter.requires() )
		{
			if (components[c] == null) return;
		}


		Logging.trace('System ${this.type} added entity ${e.id}');
		targets[e.id]=e;
	}

	@:allow(ecs.Engine)
	private function removeEntity(e:Entity):Void
	{
		Logging.trace('System ${this.type} removed entity ${e.id}');
		targets.remove(e.id);
	}	
	
	public function update(dt:Float):Void
	{}
}

	

