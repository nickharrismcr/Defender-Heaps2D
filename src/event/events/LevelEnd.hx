package event.events;
 
import ecs.Entity;

class LevelEndEvent implements IEvent {
	public var type:EventType = LevelStart;
	public var entity:Entity;

	public function new() {}
}
