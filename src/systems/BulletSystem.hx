package systems;
 
import components.update.PosComponent;
import components.update.TimerComponent;
import components.update.BulletComponent;
import components.draw.DrawComponent;

import event.events.FireBulletEvent;
import event.events.KilledEvent;

import ecs.System;
import ecs.Filter;
import ecs.Entity;




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
		this.fire(ev.firer,ev.target);
	}

	public function fire(firer:PosComponent, target:PosComponent)
	{
		var e = new Entity();
		e.addComponent(new TimerComponent());
		var p = new PosComponent();
		p.x = firer.x; 
		p.y = firer.y;
		var time = Config.settings.bullet_time;
		var vec = Utils.getBulletVector(firer,target,time);
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
					MessageCentre.notify(new KilledEvent(other));
				}
			}

			var t:TimerComponent = cast e.get(Timer);
			if ( t.t > 4 ){
				e.engine.removeEntity(e);
			}
		}
	}

	
}