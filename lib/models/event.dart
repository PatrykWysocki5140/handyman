class Event {
  final DateTime date;
  final String title;
  final String note;

  Event({required this.date, required this.title, required this.note});

  // Konwersja obiektu Event na tekstową reprezentację
  @override
  String toString() {
    return '$date|$title|$note';
  }

  // Tworzenie obiektu Event na podstawie tekstowej reprezentacji
  static Event fromString(String str) {
    List<String> parts = str.split('|');
    DateTime date = DateTime.parse(parts[0]);
    String title = parts[1];
    String note = parts[2];
    return Event(date: date, title: title, note: note);
  }
}
