package fsm;
import ecs.Enums;

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
        if ( (! this.transitions.exists(from)) || (!this.transitions[from].contains(to))) {
            throw new haxe.Exception('Invalid transition $from -> $to ');
        }
    }
}