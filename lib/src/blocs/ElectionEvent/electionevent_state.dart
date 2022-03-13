part of 'electionevent_bloc.dart';

@immutable
abstract class ElectioneventState {}

class ElectioneventInitial extends ElectioneventState {}

class AllElectionEventsRetrieved extends ElectioneventState {
  final List<ElectionEvent> electionEvents;
  AllElectionEventsRetrieved({this.electionEvents});
}
