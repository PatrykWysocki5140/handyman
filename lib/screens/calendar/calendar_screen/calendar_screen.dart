import 'package:flutter/material.dart';
import 'package:handyman/bloc/calendar_bloc/calendar_bloc.dart';
import 'package:handyman/models/event.dart';
import 'package:handyman/screens/calendar/calendar_screen/add_event_screen.dart';

class CalendarApp extends StatefulWidget {
  @override
  _CalendarAppState createState() => _CalendarAppState();
}

class _CalendarAppState extends State<CalendarApp> {
  final CalendarBloc _calendarBloc = CalendarBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),
      ),
      body: StreamBuilder<List<Event>>(
        stream: _calendarBloc.eventsStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final events = snapshot.data!;
            return ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                return ListTile(
                  title: Text(event.title),
                  subtitle: Text(event.date.toString()),
                  onTap: () => _showEventDetails(event),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showAddEventForm(),
      ),
    );
  }

  void _showEventDetails(Event event) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(event.title),
        content: Text(event.note),
        actions: [
          TextButton(
            child: Text('Close'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _showAddEventForm() {
    showDialog(
      context: context,
      builder: (context) => EventForm(
        onSave: (title, date, note) {
          _calendarBloc.addEvent(Event(title: title, date: date, note: note));
          Navigator.pop(context);
        },
      ),
    );
  }
}
