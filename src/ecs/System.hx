package ecs;

import ecs.Entity;
import ecs.Engine;
import ecs.IComponent;

interface ISystem {
	public var type:SystemType;
	public function update(dt:Float):Void;
	public function onAddEntity(e:Entity):Void;
	public function onRemoveEntity(e:Entity):Void;
	private var filter:Filter;
}

class System implements ISystem {
	public var active:Bool;
	public var type:SystemType;

	private var engine:Engine;
	private var filter:Filter;
	private var targets:Map<Int, Entity>;

	public function new() {
		this.targets = new Map<Int, Entity>();
	}

	public function onAddEntity(e:Entity) {}

	public function onRemoveEntity(e:Entity) {}

	public function needsComponent(c:ComponentType):Bool {
		return this.filter.needsComponent(c);
	}

	@:allow(ecs.Engine)
	private function setEngine(eng:Engine) {
		this.engine = eng;
	}

	@:allow(ecs.Engine)
	private function addEntityIfReqd(e:Entity):Void {
		var components = e.getComponents();
		for (c in this.filter.requires()) {
			if (components[c] == null)
				return;
		}

		Logging.trace('System ${this.type} added entity ${e.id}');
		this.targets[e.id] = e;
		this.onAddEntity(e);
	}

	@:allow(ecs.Engine)
	private function removeEntity(e:Entity):Void {
		if (this.targets.exists(e.id)) {
			Logging.trace('System ${this.type} removed entity ${e.id}');
			this.targets.remove(e.id);
			this.onRemoveEntity(e);
		}
	}

	public function update(dt:Float):Void {}
}
