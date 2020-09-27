package ecs;

import ecs.Entity;
import ecs.Engine;

interface ISystem { 

	public function update(dt:Float):Void;
	private var filter:Filter;
}

class System implements ISystem  { 

	var targets:Array<Entity>;
	var filter:Filter;

	public function new() 
	{
		this.targets=new Array<Entity>();
	}

	@:allow(ecs.Engine)
	private function addEntity(e:Entity):Void
	{
		var components = e.getComponents();
		for ( c in this.filter.requires() )
		{
			if (components[c] == null) return;
		}
		targets.push(e);
	}

	public function update(dt:Float):Void
	{}
}

	

