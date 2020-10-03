package event.events;

import components.update.PosComponent;
import event.MessageCentre;
import ecs.Entity;
import Enums;

class FireBulletEvent implements IEvent
{
	public var type:EventType = FireBullet;
	public var entity:Entity;
	public var firer:PosComponent;
	public var target:PosComponent;

	public function new(e:Entity,firer:PosComponent,target:PosComponent)
	{
		this.entity=e;
		this.firer=firer;
		this.target=target;
	}
}