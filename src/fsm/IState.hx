package fsm;

import fsm.FSMComponent;
import ecs.Entity;

interface IState
{
    public function enter(c:FSMComponent,e:Entity):Void;
    public function update(c:FSMComponent,e:Entity):Void;
    public function exit(c:FSMComponent,e:Entity):Void;
}

