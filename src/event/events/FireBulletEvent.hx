package event.events;

import event.MessageCentre;
import ecs.Entity;
import Enums;

class FireBulletEvent implements IEvent
{
	public var type:EventType = FireBullet;
	public var entity:Entity;
	public var x:Float;
	public var y:Float;
	public var targx:Float;
	public var targy:Float;

	public function new(e:Entity,x:Float,y:Float,targx:Float,targy:Float)
	{
		this.entity=e;
		this.x=x;
		this.y=y;
		this.targx=targx;
		this.targy=targy;
	}
}
