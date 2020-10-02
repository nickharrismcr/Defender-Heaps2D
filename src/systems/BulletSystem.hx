package systems;

import fsm.FSMComponent;
import components.update.CollideComponent;
import components.draw.DrawComponent;
import components.update.PosComponent;
import components.update.TimerComponent;
import components.draw.DrawComponent;
import components.update.BulletComponent;
import components.update.TimerComponent;
import event.events.FireBulletEvent;
import ecs.System;
import ecs.Filter;
import ecs.Entity;
import event.MessageCentre;
import Enums;
import logging.Logging;

class BulletSystem extends System implements ISystem
{
	public function new( )
	{
		super( );
		this.type=BulletSystem;
		this.filter=new Filter();
		filter.add(Bullet); 
		filter.add(Timer);
		filter.add(Pos);
	}

	public function fireEvent(event:IEvent)
	{
		var ev:FireBulletEvent = cast event;
		this.fire(ev.x,ev.y,ev.targx,ev.targy,1);
	}

	public function fire(x:Float,y:Float,targx:Float,targy:Float,time:Float)
	{
		var e = new Entity();
		e.addComponent(new TimerComponent());
		var p = new PosComponent();
		p.x = x; 
		p.y = y;
		var vec = Utils.getBulletVector(x,y,targx,targy,time);
		p.dx = vec.x;
		p.dy = vec.y;
		e.addComponent(p);
		e.addComponent( new BulletComponent());
		e.addComponent( new DrawComponent(GFX.getAnim(Bullet)));
		this.engine.addEntity(e);
	}

	public override function update(dt:Float)
	{
		for ( e in this.targets )
		{
			var bp:PosComponent = cast e.get(Pos);
			bp.x = bp.x+bp.dx * dt;
			bp.y = bp.y+bp.dy * dt;

			var bd:DrawComponent = cast e.get(Draw);
			for ( other in this.engine.getEntitiesWithComponent(Shootable))
			{
				var od:DrawComponent = cast other.get(Draw);
				if ( od.drawable.getBounds().intersects(bd.drawable.getBounds()))
				{
					this.engine.removeEntity(e);
					this.engine.removeEntity(other);
				}
			}

			var t:TimerComponent = cast e.get(Timer);
			if ( t.t > 2 ){
				e.engine.removeEntity(e);
			}
		}
	}

	
}