import 'package:bloc/bloc.dart';
import 'package:dapp_election_user/models/Election/ElectionEvent.dart';
import 'package:dapp_election_user/resources/EventService.dart';
import 'package:meta/meta.dart';

part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  EventBloc() : super(EventInitial());
  final eventService = EventService();
  @override
  Stream<EventState> mapEventToState(
    EventEvent event,
  ) async* {
    if (event is GetListOfEvents) {
      yield EventLoading();
      try {
        print("EventBloc: GetListOfEvents event");

        final allEventsMap = await eventService.getAllEvents();
        yield AllEventsRetrieved(listElectionEvents: allEventsMap);
      } catch (e) {
        print('Error in GetListOfEvents event: $e');
        yield EventError(error: e.toString());
      }
    }
  }
}
