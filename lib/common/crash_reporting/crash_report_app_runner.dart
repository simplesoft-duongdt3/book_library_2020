import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'crash_report.dart';

class CrashReportAppRunner {

  void startApp(Widget app) {
    FlutterError.onError = (details, {bool forceReport = false}) async {
      try {
        await CrashReport.getInstance().reportError(
          exception: details.exception,
          stackTrace: details.stack,
        );
      } catch (e) {
        print('Sending report to sentry.io failed: $e');
      } finally {
        // Also use Flutter's pretty error logging to the device's console.
        FlutterError.dumpErrorToConsole(details, forceReport: forceReport);
      }
    };

    runZoned(
          () => runApp(app),
      onError: (Object error, StackTrace stackTrace) async {
        try {
          await CrashReport.getInstance().reportError(
            exception: error,
            stackTrace: stackTrace,
          );
          print('Error sent to sentry.io: $error');
        } catch (e) {
          print('Sending report to sentry.io failed: $e');
          print('Original error: $error');
        }
      },
    );
  }

}
