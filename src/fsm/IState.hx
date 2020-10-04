package fsm;

import fsm.FSMComponent;
import ecs.Entity;


interface IState
{
    public var state:States;
    public function enter(c:FSMComponent,e:Entity,dt:Float):Void;
    public function update(c:FSMComponent,e:Entity,dt:Float):Void;
    public function exit(c:FSMComponent,e:Entity,dt:Float):Void;
}

