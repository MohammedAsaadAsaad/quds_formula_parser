import 'package:quds_formula_parser/quds_formula_parser.dart';

/// A class representing both a [Date] and [Time] combined into a single unit of time.
class QudsDateTime {
  final Date date;
  final Time time;

  /// Constructs a [QudsDateTime] with the provided [date] and [time].
  QudsDateTime(this.date, this.time);

  /// Returns the number of days in the specified [month] of the given [year].
  ///
  /// Accounts for leap years when calculating days in February.
  int getDaysInMonth(int year, int month) {
    List<int> daysInMonths = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    if (month == 2 && (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0))) {
      return 29; // Leap year
    }
    return daysInMonths[month - 1];
  }

  /// Adds the given [duration] to the current [QudsDateTime] and returns a new [QudsDateTime].
  QudsDateTime add(QudsDuration duration) {
    // Calculate the new time and date after adding the duration.
    int newSeconds = time.hour * 3600 +
        time.minute * 60 +
        time.second +
        duration.toSeconds();

    int newHour = (newSeconds ~/ 3600) % 24;
    int totalMinutes = (newSeconds ~/ 60) % 60;
    int newSecond = newSeconds % 60;
    int newDay = date.day + (newSeconds ~/ 86400);
    int newMonth = date.month;
    int newYear = date.year;

    // Handle month and year overflow.
    while (newDay > getDaysInMonth(newYear, newMonth)) {
      newDay -= getDaysInMonth(newYear, newMonth);
      newMonth++;
      if (newMonth > 12) {
        newMonth = 1;
        newYear++;
      }
    }

    return QudsDateTime(Date(newYear, newMonth, newDay),
        Time(newHour, totalMinutes, newSecond));
  }

  /// Subtracts the given [duration] from the current [QudsDateTime] and returns a new [QudsDateTime].
  ///
  /// Throws an exception if the resulting time is before the minimum representable date.
  QudsDateTime subtract(QudsDuration duration) {
    int totalSeconds = duration.toSeconds();
    int currentTotalSeconds =
        date.day * 86400 + time.hour * 3600 + time.minute * 60 + time.second;
    int newTotalSeconds = currentTotalSeconds - totalSeconds;

    if (newTotalSeconds < 0) {
      throw Exception(
          "Resulting QudsDateTime is before the minimum representable date.");
    }

    int newDay = newTotalSeconds ~/ 86400;
    int newHour = (newTotalSeconds ~/ 3600) % 24;
    int newMinute = (newTotalSeconds ~/ 60) % 60;
    int newSecond = newTotalSeconds % 60;

    int newMonth = date.month;
    int newYear = date.year;

    // Handle underflow for days.
    while (newDay < 1) {
      newMonth--;
      if (newMonth < 1) {
        newMonth = 12;
        newYear--;
      }
      newDay += getDaysInMonth(newYear, newMonth);
    }

    return QudsDateTime(
        Date(newYear, newMonth, newDay), Time(newHour, newMinute, newSecond));
  }

  /// Returns the difference between this [QudsDateTime] and another [QudsDateTime] as a [QudsDuration].
  QudsDuration difference(QudsDateTime other) {
    int thisTotalSeconds = toTotalSeconds();
    int otherTotalSeconds = other.toTotalSeconds();
    int diffSeconds = (thisTotalSeconds - otherTotalSeconds).abs();

    return QudsDuration.fromSeconds(diffSeconds);
  }

  /// Converts the current [QudsDateTime] into total seconds since the start of the day.
  int toTotalSeconds() {
    return (date.day * 86400) +
        (time.hour * 3600) +
        (time.minute * 60) +
        time.second;
  }

  /// Formats the [QudsDateTime] according to the given [formatString].
  ///
  /// Supported tokens:
  /// - `yyyy`: year
  /// - `MM`: month (two digits)
  /// - `dd`: day (two digits)
  /// - `HH`: hours (two digits)
  /// - `mm`: minutes (two digits)
  /// - `ss`: seconds (two digits)
  String format(String formatString) {
    return formatString
        .replaceAll('yyyy', date.year.toString())
        .replaceAll('MM', date.month.toString().padLeft(2, '0'))
        .replaceAll('dd', date.day.toString().padLeft(2, '0'))
        .replaceAll('HH', time.hour.toString().padLeft(2, '0'))
        .replaceAll('mm', time.minute.toString().padLeft(2, '0'))
        .replaceAll('ss', time.second.toString().padLeft(2, '0'));
  }

  /// Adds a specified number of [daysToAdd] to the current date.
  QudsDateTime addDays(int daysToAdd) {
    Date newDate = date.addDays(daysToAdd);
    return QudsDateTime(newDate, time);
  }

  /// Adds a specified number of [secondsToAdd] to the current time.
  QudsDateTime addSeconds(int secondsToAdd) {
    Time newTime = time.addSeconds(secondsToAdd);
    Date newDate = date;
    if (newTime.hour < time.hour) {
      newDate = date.addDays(1);
    }
    return QudsDateTime(newDate, newTime);
  }

  /// Checks if this [QudsDateTime] is before another [QudsDateTime].
  bool isBefore(QudsDateTime other) {
    return toTotalSeconds() < other.toTotalSeconds();
  }

  /// Checks if this [QudsDateTime] is after another [QudsDateTime].
  bool isAfter(QudsDateTime other) {
    return toTotalSeconds() > other.toTotalSeconds();
  }

  /// Checks if this [QudsDateTime] is equal to another [QudsDateTime].
  bool isEqual(QudsDateTime other) {
    return toTotalSeconds() == other.toTotalSeconds();
  }

  @override
  String toString() {
    return '$date $time';
  }

  /// Comparison operators for comparing [QudsDateTime] objects.
  bool operator >(QudsDateTime other) {
    if (date > other.date) return true;
    if (date == other.date) return time > other.time;
    return false;
  }

  bool operator <(QudsDateTime other) {
    if (date < other.date) return true;
    if (date == other.date) return time < other.time;
    return false;
  }

  bool operator >=(QudsDateTime other) {
    return this > other || this == other;
  }

  bool operator <=(QudsDateTime other) {
    return this < other || this == other;
  }

  @override
  bool operator ==(Object other) =>
      other is QudsDateTime && date == other.date && time == other.time;

  @override
  int get hashCode => date.hashCode ^ time.hashCode;
}

/// A wrapper class for the [QudsDateTime] type used within the formula system.
class QudsDateTimeWrapper extends ValueWrapper<QudsDateTime> {
  /// Creates a [QudsDateTimeWrapper] that wraps a [QudsDateTime] object.
  QudsDateTimeWrapper(super.value);

  /// Returns the type of the value as `'DateTime'`.
  @override
  String get valueType => 'DateTime';

  @override
  String get toTexNotation =>
      '#${value.date.year}-${value.date.month.toString().padLeft(2, '0')}-${value.date.day.toString().padLeft(2, '0')} ${value.time.hour.toString().padLeft(2, '0')}:${value.time.minute.toString().padLeft(2, '0')}:${value.time.second.toString().padLeft(2, '0')}#';
}
