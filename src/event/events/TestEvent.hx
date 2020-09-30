package event.events;

import event.MessageCentre;
import ecs.Entity;
import Enums;

class TestEvent implements IEvent
{
	public var type:EventType = TestEventType;
	public var entity:Entity;

	public function new(e:Entity)
	{
		this.entity=e;
	}
}
