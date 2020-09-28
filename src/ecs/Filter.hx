package ecs;

import ecs.Component;

@:forward
abstract Components(Array<Class<Component>>) from Array<Class<Component>> to Array<Class<Component>>
{
	@:from
	public static inline function fromComponent(component:Class<Component>):Components
	{
		return [component]; 
	}
}

class Filter
{
	public var required:Array<String>;
	public function new()
	{
		this.required=new Array<String>();
	}

	// component class or list of component classes
	public function add(components:Components):Void
	{
		for ( c in components ) 
		{
			this.required.push(Type.getClassName(c));
		}
	}

	public function needsComponent(c:Component)
	{
		return this.required.contains(c.typeName);
	}

	public function requires():Array<String>
	{
		return required;
	}
}

