part of 'electioneventselected_bloc.dart';

@immutable
abstract class ElectioneventselectedEvent {}

class GetSingleEvent extends ElectioneventselectedEvent {
  final String eid;
  GetSingleEvent({@required this.eid});
}
