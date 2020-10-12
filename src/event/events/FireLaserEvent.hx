package event.events;

import components.update.PosComponent;
 
import ecs.Entity;
 
class FireLaserEvent implements IEvent
{
	public var type:EventType = FireLaser;
	public var entity:Entity;
	public var firer:PosComponent;
	 

	public function new(e:Entity,firer:PosComponent)
	{
		this.entity=e;
		this.firer=firer;
	}
}
