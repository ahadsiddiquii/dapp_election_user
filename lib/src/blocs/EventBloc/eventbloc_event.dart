part of 'eventbloc_bloc.dart';

@immutable
abstract class EventblocEvent {}

class EventsDetailsInsert extends EventblocEvent {
  final String eventName, startDate, endDate;
  EventsDetailsInsert(
      {@required this.eventName,
      @required this.startDate,
      @required this.endDate});
}

class ResetEventData extends EventblocEvent {}
