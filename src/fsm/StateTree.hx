package fsm;

import logging.Logging;
import Enums;

class StateTree
{
    var transitions: Map<States,Array<States>>;

    public function new()
    {
        this.transitions=new Map<States,Array<States>>();
    }

    public function addTransition(from:States,to:States)
    {
        if (!this.transitions.exists(from)){
            this.transitions[from]=[];
        }
        this.transitions[from].push(to);
    }

    public function validTransition(from:States,to:States)
    {
        if  ((! this.transitions.exists(from)) || ( ! this.checkTransitions(from,to)))  {
            throw new haxe.Exception('Invalid transition $from -> $to ');
        }
    }

    private function checkTransitions(from:States, to:States)
    {
        for ( v in this.transitions[from]) {
            if (v.equals(to)) return true;
        }
        return false;
    }
}