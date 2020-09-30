package test;

import Enums;
import fsm.IState;
import fsm.FSMComponent;
import fsm.StateTree;
import logging.Logging;
import ecs.Entity;
import ecs.Filter;
import ecs.IComponent;
import ecs.System;
import ecs.Engine;

import fsm.FSMSystem;
import states.npc.lander.LanderMaterialize;
import states.npc.lander.LanderWait;
import components.update.PosComponent;
import components.update.DrawComponent;
import systems.DrawSystem;
import event.MessageCentre;
import event.events.TestEvent;


class Test {

	public static function run():Void
	{
		function testfn(ev:IEvent)
		{
			Logging.trace('testfn ent: ${ev.entity.id}');
		}

		MessageCentre.register(TestEventType,testfn);
		
		Logging.level=ERROR;
		
        var eng=new Engine();
		var sys=new FSMSystem();
		sys.register(new LanderWait());
		sys.register(new LanderMaterialize());

		eng.addUpdateSystem(sys);
		var tree = new StateTree();
		tree.addTransition(Lander(Wait),Lander(Materialize));
		sys.setStateTree(tree);

		var dsys=new DrawSystem();
		eng.addDrawSystem(dsys);
		MessageCentre.register(TestEventType,dsys.onEvent);

		var e = new Entity();
		e.addComponent(new FSMComponent(Lander(Wait)));
		e.addComponent(new PosComponent ());
		e.addComponent(new DrawComponent ());
		eng.addEntity(e);

		var ev=new TestEvent(e);
		MessageCentre.notify(ev);

		eng.update(0);
		eng.draw(0);
		
	}
}
