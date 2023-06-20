import 'package:handyman/models/event.dart';

abstract class EventRepository {
  void saveEvent(Event event);
  List<Event> getEvents();
}

class EventRepositoryImpl implements EventRepository {
  @override
  void saveEvent(Event event) {
    // Zapisz wydarzenie w pamięci telefonu
  }

  @override
  List<Event> getEvents() {
    // Pobierz zapisane wydarzenia z pamięci telefonu
    return [];
  }
}
