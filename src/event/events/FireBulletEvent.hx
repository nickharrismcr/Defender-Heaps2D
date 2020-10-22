package event.events;

import components.update.PosComponent;
 
import ecs.Entity;
 
class FireBulletEvent implements IEvent
{
	public var type:EventType = FireBullet;
	public var entity:Entity;
	public var firer:PosComponent;
	public var target:PosComponent;
	public var bullet_type:BulletType;

	public function new(e:Entity,firer:PosComponent,target:PosComponent,?type:BulletType)
	{
		this.entity=e;
		this.firer=firer;
		this.target=target;
		this.bullet_type=Bullet;
		if ( type != null ){
			this.bullet_type=type;
		}
		
	}
}
