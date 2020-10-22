package event;

import ecs.Entity;

interface IEvent {
	public var type:EventType;
	public var entity:Entity;
}

typedef Handler = (IEvent) -> Void;

class MessageCentre {
	public static var listeners:Null<Map<EventType, Array<Handler>>>;

	public static function register(t:EventType, h:Handler) {
		if (MessageCentre.listeners == null) {
			MessageCentre.listeners = new Map<EventType, Array<Handler>>();
		}
		if (!MessageCentre.listeners.exists(t)) {
			MessageCentre.listeners[t] = [];
		}
		MessageCentre.listeners[t].push(h);
	}

	public static function notify(e:IEvent) {
		if (MessageCentre.listeners.exists(e.type)) {
			for (h in MessageCentre.listeners[e.type]) {
				Logging.trace('Event ${e.type}');
				h(e);
			}
		}
	}
}
