part of 'electioneventselected_bloc.dart';

@immutable
abstract class ElectioneventselectedState {}

class ElectioneventselectedInitial extends ElectioneventselectedState {}

class SingleElectionRetrieved extends ElectioneventselectedState {
  final ElectionEvent singleEventData;
  SingleElectionRetrieved({this.singleEventData});
}
