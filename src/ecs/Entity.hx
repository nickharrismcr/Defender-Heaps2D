package ecs;

import logging.Logging;
import ecs.IComponent;
import Enums;


class Entity { 

	static var next_id:Int=0;
	public var id:Int;
	public var engine:Null<Engine>;

	private var components:Map<ComponentType,IComponent>;
	private var active:Bool;
	
	public function new()
	{
		this.id=Entity.next_id;
		Entity.next_id++;
		components=new Map<ComponentType,IComponent>();
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

	public function addComponent(c:IComponent):Void
	{
		Logging.trace('added component ${c.type} to Entity ${this.id}');

		components[c.type]=c;
		if (this.engine != null ) { 
			this.engine.addComponent(this,c);
		}
	}

	public function removeComponent(c:ComponentType):Void
	{
		Logging.trace('Removed component ${c} from Entity ${this.id}');
		if (this.engine != null ) { 
			this.engine.removeComponent(this,c);
		}
		this.components.remove(c);
	}

	public function getComponents():Map<ComponentType,IComponent>
	{
		return components; 
	}
 
	public function get<T>(component_type:ComponentType):Null<T>
	{
		var c = components[component_type];
		var ret:Null<T>=cast c;
		return ret;
	}

	public function has(component:ComponentType):Bool
	{
		return components.exists(component);
	}

	
}

	

