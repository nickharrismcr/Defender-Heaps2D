package ecs;

import ecs.System;
import ecs.Util;
import logging.Logging;

class Engine
{
	private var systems:Map<String,System>;
	private var update_systems:Map<String,System>;
	private var draw_systems:Map<String,System>;

	public function new()
	{
		this.systems = new Map<String,System>();
		this.update_systems=new Map<String,System>();
		this.draw_systems=new Map<String,System>();
	}

	public function addUpdateSystem(s:System):Void
	{
		this.update_systems[Util.klass(s)]=s;
		this.systems[Util.klass(s)]=s;
	}

	public function addDrawSystem(s:System):Void
	{
		this.draw_systems[Util.klass(s)]=s;
		this.systems[Util.klass(s)]=s;
	}

	public function getSystem(s:Class<System>):System
	{
		return this.systems[Type.getClassName(s)];
	}

	public function activateSystem(s:Class<System>) 
	{
		this.systems[Type.getClassName(s)].active=true;
	}

	public function deactivateSystem(s:Class<System>)
	{
		this.systems[Type.getClassName(s)].active=false;
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
	private function addComponent(e:Entity, c:Component)
	{
		Logging.trace('Add component $c to ${e.id} ');
		for ( k => s in this.update_systems)
		{
			if (s.needsComponent(c)){
				s.addEntityIfReqd(e);
			}
		}
		for ( k => s in this.draw_systems)
		{
			if (s.needsComponent(c)) {
				s.addEntityIfReqd(e);
			}
		}
	}

	@:allow(ecs.Entity)
	private function removeComponent(e:Entity, c:Component)
	{
		Logging.trace('Remove component $c from ${e.id} ');
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
