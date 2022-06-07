part of 'event_bloc.dart';

@immutable
abstract class EventEvent {}

class ResetEventData extends EventEvent {}

class GetListOfEvents extends EventEvent {}
