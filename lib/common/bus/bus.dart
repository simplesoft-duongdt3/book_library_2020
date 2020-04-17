import 'package:event_bus/event_bus.dart';

class Bus {
  EventBus eventBus = EventBus();
  static final _bus = Bus();
  static Bus get() {
    return _bus;
  }

  Stream<T> onEvent<T>() {
    return eventBus.on<T>();
  }

  void fireEvent(dynamic event) {
    eventBus.fire(event);
  }
}