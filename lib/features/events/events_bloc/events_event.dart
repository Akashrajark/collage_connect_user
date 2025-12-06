part of 'events_bloc.dart';

@immutable
sealed class EventsEvent {}

class GetAllEventsEvent extends EventsEvent {
  final Map<String, dynamic> params;

  GetAllEventsEvent({required this.params});
}

class RegisterForEventEvent extends EventsEvent {
  final int eventId;
  final String? note;

  RegisterForEventEvent({required this.eventId, this.note});
}

class GetRegisteredEventsEvent extends EventsEvent {
  final Map<String, dynamic> params;

  GetRegisteredEventsEvent({required this.params});
}
