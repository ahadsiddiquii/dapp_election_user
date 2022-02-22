part of 'eventbloc_bloc.dart';

@immutable
abstract class EventblocState {}

class EventblocInitial extends EventblocState {}

class EventDetailsInitialAdded extends EventblocState {
  final String eid, eventName, stateOfEvent, startDate, endDate;
  EventDetailsInitialAdded(
      {@required this.eid,
      @required this.eventName,
      @required this.startDate,
      @required this.endDate,
      @required this.stateOfEvent});
}
