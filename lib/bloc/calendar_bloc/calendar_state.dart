import 'package:handyman/models/event.dart';

// Stany
abstract class CalendarState {}

class CalendarInitialState extends CalendarState {}

class CalendarLoadedState extends CalendarState {
  final List<Event> events;

  CalendarLoadedState({required this.events});
}
