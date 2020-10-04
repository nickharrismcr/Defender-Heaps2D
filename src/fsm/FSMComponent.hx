package fsm;

import ecs.IComponent;


class FSMComponent implements IComponent
{
    public var type:ComponentType;
    public var state:States;
    public var next_state:Null<States>;

    public function new(init_state:States) 
    {
        this.type=FSM;
        this.state=null;
        this.next_state=init_state;
    }
}

