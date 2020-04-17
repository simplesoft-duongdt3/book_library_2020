import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:sentry/sentry.dart';

class CrashReport {

  final int maxSizeEventBloc = 10;
  final Queue _stackEventBloc = new Queue();
  final SentryClient _sentryClient = new SentryClient(
      dsn: "https://7f347510c96d4fa6a77280df3274effd@sentry.io/1814973");

  static final CrashReport _crashReport = CrashReport._();
  CrashReport._();
  static CrashReport getInstance() {
    return _crashReport;
  }

  Future<void> reportError({dynamic exception, dynamic stackTrace}) async {
    // Print the exception to the console.
    print('Caught error: $exception');
    if (kDebugMode) {
      _sendCrash(exception, stackTrace);
      // Print the full stacktrace in debug mode.
      print(stackTrace);
      return;
    } else {
      // Send the Exception and Stacktrace to Sentry in Production mode.
      _sendCrash(exception, stackTrace);
    }
  }

  void _sendCrash(exception, stackTrace) {
    _sentryClient.captureException(exception: exception, stackTrace: stackTrace);

    final Event event = new Event(
      message: _createLogMsg(exception),
      level: SeverityLevel.debug,
      transaction: "Crash_bloc_history",
    );
    _sentryClient.capture(event: event);
  }

  void addBlocEvent(dynamic event) {
    print("addBlocEvent " + event.toString());
    if (_stackEventBloc.length >= 10) {
      _stackEventBloc.removeLast();
    }

    _stackEventBloc.addFirst(event);
  }

  void addBlocTransaction(dynamic transaction) {
    print("addBlocTransaction " + transaction.toString());
    if (_stackEventBloc.length >= 10) {
      _stackEventBloc.removeLast();
    }

    _stackEventBloc.addFirst(transaction);
  }

  String _createLogMsg(dynamic exception) {
    StringBuffer stringBuffer = StringBuffer("");
    stringBuffer.write("$exception");
    for(var i = 0; i < _stackEventBloc.length; i++) {
      stringBuffer.write("\r\n${i + 1}. ${_stackEventBloc.elementAt(i)}");
    }
    return stringBuffer.toString();
  }
}
