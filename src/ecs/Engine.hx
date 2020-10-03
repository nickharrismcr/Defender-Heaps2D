package ecs;

import haxe.io.Encoding;
import ecs.System;
import ecs.IComponent;
import logging.Logging;
import Enums;
import ecs.Job;

class Engine
{
	public var app:hxd.App;
	
	private var systems:Map<SystemType,System>;
	private var update_systems:Map<SystemType,System>;
	private var draw_systems:Map<SystemType,System>;
	private var run_time:Float;
	private var sched_queue:Array<Job>;
	private var ents_with_comp:Map<ComponentType,Array<Entity>>;
	private var entity_list:Map<Int,Entity>;

	public function new(app:hxd.App)
	{
		this.app=app;
		this.systems = new Map<SystemType,System>();
		this.update_systems=new Map<SystemType,System>();
		this.draw_systems=new Map<SystemType,System>();
		this.ents_with_comp = new Map<ComponentType,Array<Entity>>();
		this.sched_queue= new Array<Job>();
		this.entity_list = new Map<Int,Entity>();
		this.run_time=0;
	}

	public function addUpdateSystem(s:System):Void
	{
		Logging.trace('Added update system ${s.type} to Engine');
		if (s.type==null) throw new haxe.Exception('System $s type is null');
		s.active=true;
		s.setEngine(this);
		this.update_systems[s.type]=s;
		this.systems[s.type]=s;
	}

	public function addDrawSystem(s:System):Void
	{
		 
		Logging.trace('Added draw system ${s.type} to Engine');
		if (s.type==null) throw new haxe.Exception('System $s type is null');
		s.active=true;
		s.setEngine(this);
		this.draw_systems[s.type]=s;
		this.systems[s.type]=s;
	}

	public function getSystem(s:SystemType):System
	{
		return this.systems[s];
	}

	public function activateSystem(s:SystemType) 
	{
		this.systems[s].active=true;
	}

	public function deactivateSystem(s:SystemType)
	{
		this.systems[s].active=false;
	}

	public function addEntity(e:Entity)
	{
		Logging.trace('Added Entity ${e.id} to Engine');
		e.engine=this;
		e.activate();
		this.entity_list[e.id]=e;
	
	}

	public function onActivateEntity(e:Entity)
	{
		Logging.trace('Activated Entity ${e.id} in Engine');
		for ( c in e.getComponents())
		{
			this.addToEntitiesWithComp(c,e);
		}
		for ( k => s in this.update_systems ) {
			s.addEntityIfReqd(e);
		}
		for ( k => s in this.draw_systems ){
			s.addEntityIfReqd(e);
		}
	}

	public function removeEntity(e:Entity)
	{
		Logging.trace('Removed Entity ${e.id} from Engine');
		this.entity_list.remove(e.id);
		for ( c in e.getComponents())
		{
			this.removeFromEntitiesWithComp(c.type,e);
		}

		for ( k => s in this.update_systems){
			s.removeEntity(e);
		}
		for ( k => s in this.draw_systems) {
			s.removeEntity(e);
		}
	}

	public function onDeactivateEntity(e:Entity)
	{
		Logging.trace('Deactivate Entity ${e.id} in Engine');
		for ( c in e.getComponents())
		{
			this.removeFromEntitiesWithComp(c.type,e);
		}
		
		for ( k => s in this.update_systems){
			s.removeEntity(e);
		}
		for ( k => s in this.draw_systems) {
			s.removeEntity(e);
		}
	}

	@:allow(ecs.Entity)
	private function addComponent(e:Entity, c:IComponent)
	{
		Logging.trace('Add component $c to ${e.id} ');
		
		this.addToEntitiesWithComp(c,e);
		
		for ( k => s in this.update_systems)
		{
			if (s.needsComponent(c.type)){
				s.addEntityIfReqd(e);
			}
		}
		for ( k => s in this.draw_systems)
		{
			if (s.needsComponent(c.type)) {
				s.addEntityIfReqd(e);
			}
		}
	}

	@:allow(ecs.Entity)
	private function removeComponent(e:Entity, c:ComponentType)
	{
		Logging.trace('Remove component $c from ${e.id} ');
		this.removeFromEntitiesWithComp(c,e);
		
		for ( k => s in this.update_systems)
		{
			if (s.needsComponent(c)){
				s.removeEntity(e);
			}
		}
		for ( k => s in this.draw_systems)
		{
			if (s.needsComponent(c)) {
				s.removeEntity(e);
			}
		}
	}

	private function addToEntitiesWithComp(c:IComponent,e:Entity)
	{
		if (! this.ents_with_comp.exists(c.type))
		{
			this.ents_with_comp[c.type]=[];
		}
		this.ents_with_comp[c.type].push(e);
	}

	private function removeFromEntitiesWithComp(c:ComponentType,e:Entity)
	{
		if ( this.ents_with_comp.exists(c))
		{
			this.ents_with_comp[c].remove(e);
		}
	}
		
	private function hasEntity(e:Entity)
	{
		return this.entity_list.exists(e.id);
	}

	public function getEntitiesWithComponent(c:ComponentType):Array<Entity>
	{
		if ( this.ents_with_comp[c] == null ) return [];
		// TODO : optimise?
		return Lambda.filter(this.ents_with_comp[c], (e) -> e.isActive() && this.hasEntity(e));
	}

	public function schedule(delay:Float,func:()->Void)
	{
		var j = new Job(this.run_time+delay,func);
		this.sched_queue.push(j);
	}

	public function update(dt:Float)
	{
		this.run_time += dt;

		for ( k => s in update_systems )
		{
			if (s.active) s.update(dt);
		}

		for ( job in this.sched_queue )
		{
			if (this.run_time > job.scheduled_time)
			{
				job.func();
				this.sched_queue.remove(job);
			} 
		}
	}
	public function draw(dt:Float)
	{
		for ( k => s in draw_systems )
		{
			if (s.active) s.update(dt);
		}
	}
}
