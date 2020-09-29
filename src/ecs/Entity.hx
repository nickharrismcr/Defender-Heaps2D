package ecs;

import logging.Logging;

class Entity { 

	static var next_id:Int=0;
	public var id:Int;
	public var engine:Null<Engine>;

	private var components:Map<String,Component>;
	private var active:Bool;
	
	public function new()
	{
		this.id=Entity.next_id;
		Entity.next_id++;
		components=new Map<String,Component>();
	}

	public function isActive():Bool
	{
		return this.active;
	}

	public function activate()
	{
		if (! this.active) {
			Logging.trace('Activated ${this.id}');
			this.active=true;
			if (this.engine != null){
				this.engine.onActivateEntity(this);
			}
		}
	}
 
	public function deactivate()
	{
		if (this.active) {
			Logging.trace('Deactivated ${this.id}');
			this.active=false;
			if (this.engine != null){
				this.engine.onDeactivateEntity(this);
			}
		}  
	}

	public function addComponent(c:Component):Void
	{
		Logging.trace('added component ${Util.klass(c)} to Entity ${this.id}');

		components[Util.klass(c)]=c;
		if (this.engine != null ) { 
			this.engine.addComponent(this,c);
		}
	}

	public function removeComponent(c:Component):Void
	{
		Logging.trace('Removed component ${Util.klass(c)} from Entity ${this.id}');

		this.components.remove(Util.klass(c));
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

	
}

	

