import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'eventbloc_event.dart';
part 'eventbloc_state.dart';

class EventblocBloc extends Bloc<EventblocEvent, EventblocState> {
  EventblocBloc() : super(EventblocInitial());

  @override
  Stream<EventblocState> mapEventToState(
    EventblocEvent event,
  ) async* {
    if (event is EventsDetailsInsert) {
      yield EventDetailsInitialAdded(
          eid: "A",
          eventName: event.eventName,
          stateOfEvent: "inProgress",
          startDate: event.startDate,
          endDate: event.endDate);
    } else if (event is ResetEventData) {
      yield EventblocInitial();
    }
  }
}
