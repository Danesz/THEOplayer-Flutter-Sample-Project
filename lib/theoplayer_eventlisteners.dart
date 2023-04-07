typedef EventListener<Event> = void Function(Event event);

class Event {
  String type;
  dynamic data;

  Event({required this.type, this.data});
}

class CurrentTimeEvent extends Event {
  double currentTime;
  CurrentTimeEvent({required this.currentTime} ) : super(type: PlayerEventTypes.kCurrentTimeEvent);
}

class PlayerEventTypes {
  static const kCurrentTimeEvent = "currentTimeEvent";
}