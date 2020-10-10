package fsm;

import ecs.Filter;
import ecs.System;
import ecs.Entity;
import fsm.StateTree;

class FSMSystem implements ISystem extends System {
	var stateMap:Map<States, IState>;
	var stateTree:StateTree;

	public function new() {
		super();
		this.filter = new Filter();
		this.filter.add(FSM);
		this.stateMap = new Map<States, IState>();
		this.type = FSMSystem;
	}

	public function register(v:IState) {
		this.stateMap[v.state] = v;
	}

	public function setStateTree(s:StateTree) {
		this.stateTree = s;
	}

	public override function update(dt:Float):Void {
		if (this.stateTree == null)
			throw new haxe.Exception("FSM state tree not set");

		for (k => e in this.targets) {
			this.process(e, dt);
		}
	}

	private function process(e:Entity, dt:Float) {
		var statecls:IState;
		var e_fsm:FSMComponent = cast e.get(FSM);

		if (e_fsm.next_state != null && e_fsm.next_state != e_fsm.state) {
			if (e_fsm.state != null) {
				statecls = this.getStateClass(e_fsm.state);
				statecls.exit(e_fsm, e, dt);
				this.stateTree.validTransition(e_fsm.state, e_fsm.next_state);
			}
			Logging.trace('Entity ${e.id} : ${e_fsm.state} -> ${e_fsm.next_state}');

			statecls = this.getStateClass(e_fsm.next_state);
			statecls.enter(e_fsm, e, dt);
			e_fsm.state = e_fsm.next_state;
			e_fsm.next_state = null;
		}
		statecls = this.getStateClass(e_fsm.state);
		statecls.update(e_fsm, e, dt);
	}

	private function getStateClass(s:States):IState {
		var statecls = this.stateMap[s];
		if (statecls == null)
			throw new haxe.Exception('Unregistered state ${s}');
		return statecls;
	}
}
