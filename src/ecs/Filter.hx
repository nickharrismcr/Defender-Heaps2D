package ecs;

import ecs.IComponent;
import ecs.Enums;

@:forward
abstract Components(Array<ComponentType>) from Array<ComponentType> to Array<ComponentType>
{
	@:from
	public static inline function fromComponent(component:ComponentType):Components
	{
		return [component]; 
	}
}

class Filter
{
	public var required:Array<ComponentType>;
	public function new()
	{
		this.required=new Array<ComponentType>();
	}

	// component class or list of component classes
	public function add(components:Components):Void
	{
		for ( c in components ) 
		{
			this.required.push(c);
		}
	}

	public function needsComponent(c:ComponentType)
	{
		return this.required.contains(c);
	}

	public function requires():Array<ComponentType>
	{
		return required;
	}
}

