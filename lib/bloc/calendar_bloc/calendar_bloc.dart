import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:handyman/bloc/calendar_bloc/calendar_event.dart';
import 'package:handyman/bloc/calendar_bloc/calendar_state.dart';
import 'package:handyman/models/event.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*
class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  List<Event> _events = [];

  CalendarBloc() : super(CalendarInitialState());

  @override
  Stream<CalendarState> mapEventToState(CalendarEvent event) async* {
    if (event is AddEvent) {
      _events.add(event.event);
      yield CalendarLoadedState(events: _events);
    }
  }

  void addEvent(Event event) {
    add(AddEvent(event));
  }
}
*/
class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  List<Event> _events = [];
  final StreamController<List<Event>> _eventsController =
      StreamController<List<Event>>.broadcast();

  CalendarBloc() : super(CalendarInitialState()) {
    _loadEvents();
  }

  Stream<List<Event>> get eventsStream => _eventsController.stream;

  void addEvent(Event event) {
    add(AddEvent(event));
  }

  @override
  Stream<CalendarState> mapEventToState(CalendarEvent event) async* {
    if (event is AddEvent) {
      _events.add(event.event);
      _saveEvents();
      _eventsController.sink.add(_events);
      yield CalendarLoadedState(events: _events);
    }
  }

  void _saveEvents() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> eventStrings =
        _events.map((event) => event.toString()).toList();
    await prefs.setStringList('events', eventStrings);
  }

  _loadEvents() async* {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? eventStrings = prefs.getStringList('events');
    if (eventStrings != null) {
      _events = eventStrings.map((str) => Event.fromString(str)).toList();
      _eventsController.sink.add(_events);
      yield CalendarLoadedState(events: _events);
    }
  }

  @override
  Future<void> close() {
    _eventsController.close();
    return super.close();
  }
}

class CalendarBloc2 extends Bloc<CalendarEvent, CalendarState> {
  List<Event> _events = [];

  CalendarBloc2() : super(CalendarInitialState());

  @override
  Stream<CalendarState> mapEventToState(CalendarEvent event) async* {
    if (event is AddEvent) {
      _events.add(event.event);
      yield CalendarLoadedState(events: _events);
    }
  }

  void addEvent(Event event) {
    add(AddEvent(event));
  }
}
