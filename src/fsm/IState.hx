package fsm;

import fsm.FSMComponent;
import ecs.Entity;
import Enums;

interface IState
{
    public var state:States;
    public function enter(c:FSMComponent,e:Entity):Void;
    public function update(c:FSMComponent,e:Entity):Void;
    public function exit(c:FSMComponent,e:Entity):Void;
}

