package fsm;

import ecs.Filter;
import ecs.System;
import Enums;
import ecs.Entity;
import fsm.StateTree;

class FSMSystem implements ISystem extends System
{

    var stateMap:Map<States,IState>;
    var stateTree:StateTree;

	public function new() 
	{
        super();
        this.filter=new Filter();
        this.filter.add(FSM);
        this.stateMap = new Map<States,IState>();
        this.type=FSM;
    }

    public function register(v:IState)
    {
        this.stateMap[v.state]=v;
    }

    public function setStateTree(s:StateTree)
    {
        this.stateTree=s;
    }

    public override function update(dt:Float):Void
    {   
        for ( k => e in this.targets) 
        {
            this.process(e);            
        }
    }

    private function process(e:Entity)
    {
        var e_fsm:FSMComponent = cast e.get(FSM);
        var statecls=this.stateMap[e_fsm.state];
        if ( statecls == null ) throw new haxe.Exception('Unregistered state ${e_fsm.state}');

        if (e_fsm.next_state != null && e_fsm.next_state != e_fsm.state) {
            statecls.exit(e_fsm,e);
            this.stateTree.validTransition(e_fsm.state,e_fsm.next_state);
            statecls=this.stateMap[e_fsm.next_state];
            statecls.enter(e_fsm,e);
            e_fsm.state = e_fsm.next_state;
            e_fsm.next_state = null;
        }
        statecls.update(e_fsm,e);
    }

}