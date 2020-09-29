package ecs.test;

import fsm.IState;
import fsm.FSMComponent;
import fsm.StateTree;
import logging.Logging;
import ecs.Entity;
import ecs.Filter;
import ecs.IComponent;
import ecs.System;
import ecs.Engine;
import ecs.Enums;
import fsm.FSMSystem;

class LanderWait implements IState
{
	public function new() {}

	public function enter(c:FSMComponent,e:Entity)
	{
		Logging.trace("enter landerwait");
		
	}
	public function update(c:FSMComponent,e:Entity)
	{
		Logging.trace("update landerwait");
		c.next_state=(Lander(Materialize));
	}
	public function exit(c:FSMComponent,e:Entity)
	{}
}

class LanderMaterialize implements IState
{
	public function new() {}
	
	public function enter(c:FSMComponent,e:Entity)
	{
		Logging.trace("enter lander materialize");
	}
	public function update(c:FSMComponent,e:Entity)
	{
		Logging.trace("update lander materialize");
	}
	public function exit(c:FSMComponent,e:Entity)
	{}
}
 
class Test {

	public static function run():Void
	{
        var eng=new Engine();
		var sys=new FSMSystem();
		sys.register(Lander(Wait),new LanderWait());
		sys.register(Lander(Materialize), new LanderMaterialize());
		
		eng.addUpdateSystem(sys);
		var tree = new StateTree();
		tree.addTransition(Lander(Wait),Lander(Materialize));
		var e = new Entity();
		e.addComponent(new FSMComponent(Lander(Wait)));
		eng.addEntity(e);

		eng.update(0);
		eng.update(0);
		eng.update(0);
		eng.update(0);
		eng.update(0);

        
	}
}
