import 'package:flutter/material.dart';

class EventForm extends StatefulWidget {
  final Function(String, DateTime, String) onSave;

  EventForm({required this.onSave});

  @override
  _EventFormState createState() => _EventFormState();
}

class _EventFormState extends State<EventForm> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late DateTime _date = DateTime(2023, 9, 8);
  late String _note;
  TextEditingController date = TextEditingController();
  @override
  Widget build(BuildContext context) {
    date.text = DateTime(2023, 9, 8).toString();
    return AlertDialog(
      title: Text('Add Event'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Title'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a title.';
                }
                return null;
              },
              onSaved: (value) => _title = value!,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Date'),
              controller: date,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a date.';
                }
                return null;
              },
              onSaved: (value) => _date = DateTime.parse(value!),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Note'),
              onSaved: (value) => _note = value!,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: Text('Cancel'),
          onPressed: () => Navigator.pop(context),
        ),
        TextButton(
          child: Text('Save'),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              widget.onSave(_title, _date, _note);
            }
          },
        ),
      ],
    );
  }
}
