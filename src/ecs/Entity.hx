package ecs;

import logging.Logging;

class Entity { 

	static var next_id:Int=0;
	public var id:Int;
	public var engine:Null<Engine>;

	private var components:Map<String,Component>;

	public function new()
	{
		this.id=Entity.next_id;
		Entity.next_id++;
		components=new Map<String,Component>();
	}

	public function addComponent(c:Component):Void
	{
		Logging.get().trace("added component "+this.klass(c));

		components[this.klass(c)]=c;
		if (this.engine != null ) { 
			this.engine.addComponent(this,c);
		}
	}

	public function removeComponent(c:Component):Void
	{
		this.components.remove(this.klass(c));
		if (this.engine != null ) { 
			this.engine.removeComponent(this,c);
		}
	}

	public function getComponents():Map<String,Component>
	{
		return components; 
	}

	public function get<T>(component:Class<T>):Null<T>
	{
		var c = components[Type.getClassName(component)];
		var ret:Null<T>=cast c;
		return ret;
	}

	public function has(component:Class<Component>):Bool
	{
		return components.exists(Type.getClassName(component));
	}

	private function klass(c:Component):String
	{
		return Type.getClassName(Type.getClass(c));
	}
}

	

