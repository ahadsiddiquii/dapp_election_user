import 'package:bloc/bloc.dart';
import 'package:dapp_election_user/models/Election/ElectionEvent.dart';
import 'package:meta/meta.dart';

import '../../../models/Election/BackendFunctions.dart';

part 'electionevent_event.dart';
part 'electionevent_state.dart';

class ElectioneventBloc extends Bloc<ElectioneventEvent, ElectioneventState> {
  ElectioneventBloc() : super(ElectioneventInitial());
  @override
  Stream<ElectioneventState> mapEventToState(ElectioneventEvent event) async* {
    if (event is GetElectonEvents) {
      List<ElectionEvent> eventsData = allEvents;
      yield AllElectionEventsRetrieved(electionEvents: eventsData);
    }
  }
}
