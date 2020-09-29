package ecs;

import ecs.System;
import ecs.IComponent;
import logging.Logging;
import ecs.Enums;

class Engine
{
	private var systems:Map<SystemType,System>;
	private var update_systems:Map<SystemType,System>;
	private var draw_systems:Map<SystemType,System>;

	public function new()
	{
		this.systems = new Map<SystemType,System>();
		this.update_systems=new Map<SystemType,System>();
		this.draw_systems=new Map<SystemType,System>();
	}

	public function addUpdateSystem(s:System):Void
	{
		s.active=true;
		this.update_systems[s.type]=s;
		this.systems[s.type]=s;
	}

	public function addDrawSystem(s:System):Void
	{
		s.active=true;
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
	}

	public function onActivateEntity(e:Entity)
	{
		Logging.trace('Activated Entity ${e.id} in Engine');
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
	private function removeComponent(e:Entity, c:IComponent)
	{
		Logging.trace('Remove component $c from ${e.id} ');
		for ( k => s in this.update_systems)
		{
			if (s.needsComponent(c.type)){
				s.removeEntity(e);
			}
		}
		for ( k => s in this.draw_systems)
		{
			if (s.needsComponent(c.type)) {
				s.removeEntity(e);
			}
		}
	}

	public function update(dt:Float)
	{
		for ( k => s in update_systems )
		{
			if (s.active) s.update(dt);
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
