package event.events;

import ecs.Entity;
 
 
//@:build(MyMacros.setEventTypeEnum())
class KidnapEvent implements IEvent
{
	public var human_entity:Entity;	

	public function new(e:Entity)
	{
		this.human_entity=e;
	}
}
