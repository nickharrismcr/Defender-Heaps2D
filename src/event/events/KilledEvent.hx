package event.events;

import ecs.Entity;
import event.MessageCentre;
import Enums;

class KilledEvent implements IEvent
{
	public var type:EventType = Killed;
	public var entity:Entity;
	 
	public function new(e:Entity)
	{
		this.entity=e;
	}
}
