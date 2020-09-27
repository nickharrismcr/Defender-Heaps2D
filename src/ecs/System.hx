package ecs;

import ecs.Entity;

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

	public function addEntity(e:Entity):Void
	{
		var components = e.getComponents();
		for ( c in this.filter.requires() )
		{
			if (components[c] == null) return;
		}
		trace("added");
		targets.push(e);
	}
	public function update(dt:Float):Void
	{}
}

	

