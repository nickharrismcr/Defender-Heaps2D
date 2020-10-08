package event.events;

import ecs.Entity;
 

class PlayerExplodeEvent implements IEvent
{
	public var type:EventType = PlayerExplode;
	public var entity:Entity;
	 
	public function new(e:Entity)
	{
		this.entity=e;
	}
}
