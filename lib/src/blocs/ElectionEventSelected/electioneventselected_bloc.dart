import 'package:bloc/bloc.dart';
import 'package:dapp_election_user/models/Election/ElectionEvent.dart';
import 'package:meta/meta.dart';

part 'electioneventselected_event.dart';
part 'electioneventselected_state.dart';

class ElectioneventselectedBloc
    extends Bloc<ElectioneventselectedEvent, ElectioneventselectedState> {
  ElectioneventselectedBloc() : super(ElectioneventselectedInitial());
  @override
  Stream<ElectioneventselectedState> mapEventToState(
      ElectioneventselectedEvent event) async* {
    if (event is GetSingleEvent) {
      ElectionEvent singleEventData;
      yield SingleElectionRetrieved(singleEventData: singleEventData);
    }
  }
}
