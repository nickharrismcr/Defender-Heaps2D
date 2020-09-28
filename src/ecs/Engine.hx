package ecs;

import ecs.System;

class Engine
{
	private var update_systems:Array<System>;
	private var draw_systems:Array<System>;

	public function new()
	{
		this.update_systems=new Array<System>();
		this.draw_systems=new Array<System>();
	}

	public function addUpdateSystem(s:System):Void
	{
		this.update_systems.push(s);
	}

	public function addDrawSystem(s:System):Void
	{
		this.draw_systems.push(s);
	}

	public function addEntity(e:Entity)
	{
		e.engine=this;
		for ( s in this.update_systems ) {
			s.addEntityIfReqd(e);
		}
		for ( s in this.draw_systems ){
			s.addEntityIfReqd(e);
		}
	}

	public function removeEntity(e:Entity)
	{
		for ( s in this.update_systems){
			s.removeEntity(e);
		}
		for ( s in this.draw_systems) {
			s.removeEntity(e);
		}
	}

	public function addComponent(e:Entity, c:Component)
	{
		for ( s in this.update_systems)
		{
			if (s.needsComponent(c)){
				s.addEntityIfReqd(e);
			}
		}
		for ( s in this.draw_systems)
		{
			if (s.needsComponent(c)) {
				s.addEntityIfReqd(e);
			}
		}
	}

	public function removeComponent(e:Entity, c:Component)
	{
		for ( s in this.update_systems)
		{
			if (s.needsComponent(c)){
				s.removeEntity(e);
			}
		}
		for ( s in this.draw_systems)
		{
			if (s.needsComponent(c)) {
				s.removeEntity(e);
			}
		}
	}

	public function update(dt:Float)
	{
		for ( s in update_systems )
		{
			s.update(dt);
		}
	}
	public function draw(dt:Float)
	{
		for ( s in draw_systems )
		{
			s.update(dt);
		}
	}
}
