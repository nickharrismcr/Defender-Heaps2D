package ecs;

import ecs.Entity;
import ecs.Engine;
import ecs.Component;
import logging.Logging;

interface ISystem { 

	public function update(dt:Float):Void;
	private var filter:Filter;
}

class System implements ISystem  { 

	var targets:Map<Int,Entity>;
	var filter:Filter;

	public function new() 
	{
		this.targets=new Map<Int,Entity>();
	}

	public function needsComponent(c:Component):Bool
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

		var name=Type.getClassName(Type.getClass(this)); 
		var id=e.id;
		Logging.get().trace('System $name added entity $id');
		targets[e.id]=e;
	}

	@:allow(ecs.Engine)
	private function removeEntity(e:Entity):Void
	{
		targets.remove(e.id);
	}	
	
	public function update(dt:Float):Void
	{}
}

	

