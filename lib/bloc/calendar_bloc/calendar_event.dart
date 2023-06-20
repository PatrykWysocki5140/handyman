import 'package:handyman/models/event.dart';

// Zdarzenia
abstract class CalendarEvent {}

class AddEvent extends CalendarEvent {
  final Event event;

  AddEvent(this.event);
}
