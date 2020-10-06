package event.events;

import components.update.PosComponent;
 
import ecs.Entity;
 
class HumanPlacedEvent implements IEvent
{
	public var type:EventType = HumanPlaced;
	public var entity:Entity;
	public var pos:PosComponent;

	public function new(e:Entity,pos:PosComponent)
	{
		this.entity=e;
		this.pos=pos;
	}
}
