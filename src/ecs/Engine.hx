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
		draw_systems.push(s);
	}

	public function addEntity(e:Entity)
	{
		for ( s in update_systems )
		{
			s.addEntity(e);
		}
		for ( s in draw_systems )
		{
			s.addEntity(e);
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
