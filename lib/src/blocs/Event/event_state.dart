part of 'event_bloc.dart';

@immutable
abstract class EventState {}

class EventInitial extends EventState {}

class EventError extends EventState {
  final String error;
  EventError({@required this.error});
}

class EventLoading extends EventState {}

class AllEventsRetrieved extends EventState {
  final List<ElectionEvent> listElectionEvents;
  AllEventsRetrieved({
    @required this.listElectionEvents,
  });
}
