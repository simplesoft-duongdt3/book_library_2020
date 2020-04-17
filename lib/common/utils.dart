import 'package:intl/intl.dart';

NumberFormat _numberFormat = NumberFormat("#,##0", "en_US");
NumberFormat _moneyNumberFormat = NumberFormat("#,##0.##", "en_US");
NumberFormat _percentNumberFormat = NumberFormat("0.##%", "en_US");

String formatNumber(int number) {
  return _numberFormat.format(number ?? 0);
}

String formatMoney(double money) {
  return _moneyNumberFormat.format(money ?? 0);
}

String formatPercent(double percent) {
  return _percentNumberFormat.format(percent ?? 0);
}

class DateTimeUtils {
  static final DateFormat _monthFormat = new DateFormat("MMMM yyyy");
  static final DateFormat _dayFormat = new DateFormat("dd/MM/yyyy");
  static final DateFormat _firstDayFormat = new DateFormat("MMM dd");
  static final DateFormat _fullDayFormat = new DateFormat("EEE MMM dd, yyyy");
  static final DateFormat _apiRequestDayFormat = new DateFormat("dd/MM/yyyy");
  static final DateFormat _apiResponseDayFormat =
      new DateFormat("yyyy-MM-dd HH:mm:ss");
  static final DateFormat _dayTimeFormat = new DateFormat("HH:mm dd/MM/yyyy");

  static String formatMonth(DateTime d) => _monthFormat.format(d);

  static String formatDay(DateTime d) => _dayFormat.format(d);

  static String formatFirstDay(DateTime d) => _firstDayFormat.format(d);

  static String formatDateTime(DateTime d) => _dayTimeFormat.format(d);

  static String fullDayFormat(DateTime d) => _fullDayFormat.format(d);
  static String formatApiDate(DateTime d) => _apiResponseDayFormat.format(d);

  static String apiRequestDayFormat(DateTime d) =>
      _apiRequestDayFormat.format(d);

  static const List<String> weekdays = const [
    "Sun",
    "Mon",
    "Tue",
    "Wed",
    "Thu",
    "Fri",
    "Sat"
  ];

  /// The list of days in a given month
  static List<DateTime> daysInMonth(DateTime month) {
    var first = firstDayOfMonth(month);
    var daysBefore = first.weekday;
    var firstToDisplay = first.subtract(new Duration(days: daysBefore));
    var last = DateTimeUtils.lastDayOfMonth(month);

    var daysAfter = 7 - last.weekday;

    // If the last day is sunday (7) the entire week must be rendered
    if (daysAfter == 0) {
      daysAfter = 7;
    }

    var lastToDisplay = last.add(new Duration(days: daysAfter));
    return daysInRange(firstToDisplay, lastToDisplay).toList();
  }

  static bool isFirstDayOfMonth(DateTime day) {
    return isSameDay(firstDayOfMonth(day), day);
  }

  static bool isLastDayOfMonth(DateTime day) {
    return isSameDay(lastDayOfMonth(day), day);
  }

  static DateTime firstDayOfMonth(DateTime month) {
    return new DateTime(month.year, month.month);
  }

  static DateTime mondayOfWeek(DateTime day) {
    /// Weekday is on a 1-7 scale Monday - Sunday,
    /// This Calendar works from Sunday - Monday
    var numDayFromMondayToSunday =  6;
    return sundayOfWeek(day).subtract(new Duration(days: numDayFromMondayToSunday));
  }

  static DateTime sundayOfWeek(DateTime day) {
    /// Handle Daylight Savings by setting hour to 12:00 Noon
    /// rather than the default of Midnight
    day = new DateTime.utc(day.year, day.month, day.day, 12);

    /// Weekday is on a 1-7 scale Monday - Sunday,
    /// This Calendar's Week starts on Sunday
    var numDayToSunday =  7 - day.weekday;
    return day.add(new Duration(days: numDayToSunday));
  }

  /// The last day of a given month
  static DateTime lastDayOfMonth(DateTime month) {
    var beginningNextMonth = (month.month < 12)
        ? new DateTime(month.year, month.month + 1, 1)
        : new DateTime(month.year + 1, 1, 1);
    return beginningNextMonth.subtract(new Duration(days: 1));
  }

  /// Returns a [DateTime] for each day the given range.
  ///
  /// [start] inclusive
  /// [end] exclusive
  static Iterable<DateTime> daysInRange(DateTime start, DateTime end) sync* {
    var i = start;
    var offset = start.timeZoneOffset;
    while (i.isBefore(end)) {
      yield i;
      i = i.add(new Duration(days: 1));
      var timeZoneDiff = i.timeZoneOffset - offset;
      if (timeZoneDiff.inSeconds != 0) {
        offset = i.timeZoneOffset;
        i = i.subtract(new Duration(seconds: timeZoneDiff.inSeconds));
      }
    }
  }

  /// Whether or not two times are on the same day.
  static bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  static bool isSameWeek(DateTime a, DateTime b) {
    /// Handle Daylight Savings by setting hour to 12:00 Noon
    /// rather than the default of Midnight
    a = new DateTime.utc(a.year, a.month, a.day);
    b = new DateTime.utc(b.year, b.month, b.day);

    var diff = a.toUtc().difference(b.toUtc()).inDays;
    if (diff.abs() >= 7) {
      return false;
    }

    var min = a.isBefore(b) ? a : b;
    var max = a.isBefore(b) ? b : a;
    var result = max.weekday % 7 - min.weekday % 7 >= 0;
    return result;
  }

  static DateTime previousMonth(DateTime m) {
    var year = m.year;
    var month = m.month;
    if (month == 1) {
      year--;
      month = 12;
    } else {
      month--;
    }
    return new DateTime(year, month);
  }

  static DateTime nextMonth(DateTime m) {
    var year = m.year;
    var month = m.month;

    if (month == 12) {
      year++;
      month = 1;
    } else {
      month++;
    }
    return new DateTime(year, month);
  }

  static DateTime previousWeek(DateTime w) {
    return w.subtract(new Duration(days: 7));
  }

  static DateTime nextWeek(DateTime w) {
    return w.add(new Duration(days: 7));
  }

  static DateTime yesterday(DateTime today) {
    return today.add(new Duration(days: -1));
  }

  static DateTime parseApiDateTime(String dateTime) {
    return _apiResponseDayFormat.parse(dateTime);
  }

  static int getWeekDay(DateTime dateTime) {
    if (dateTime.weekday == 7) {
      return 0;
    }
    return dateTime.weekday;
  }
}
