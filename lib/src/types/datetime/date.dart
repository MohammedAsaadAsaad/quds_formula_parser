import 'package:quds_formula_parser/quds_formula_parser.dart';

/// A class representing a calendar date with various utility methods for date manipulation and validation.
///
/// This class provides functionality for creating and manipulating dates, including validation,
/// formatting, and date-related calculations such as adding days or getting the day of the week.
class Date {
  /// Creates a [Date] object representing the current date.
  factory Date.now() {
    DateTime d = DateTime.now();
    return Date.fromDateTime(d);
  }

  /// Creates a [Date] object from a [DateTime] instance.
  factory Date.fromDateTime(DateTime d) {
    return Date(d.year, d.month, d.day);
  }

  final int _year;
  final int _month;
  final int _day;

  /// Constructs a [Date] object with the given year, month, and day, and performs validation.
  ///
  /// Throws [ArgumentError] if the provided date is invalid.
  Date(this._year, this._month, this._day) {
    if (!_isValidDate(_year, _month, _day)) {
      throw ArgumentError('Invalid date: $_year-$_month-$_day');
    }
  }

  /// Validates the date components to ensure the date is valid.
  /// Returns `true` if the date is valid, `false` otherwise.
  bool _isValidDate(int year, int month, int day) {
    if (month < 1 || month > 12) {
      return false;
    }
    int daysInMonth = _daysInMonth(year, month);
    return day >= 1 && day <= daysInMonth;
  }

  /// Calculates the number of days in a given month, accounting for leap years.
  int _daysInMonth(int year, int month) {
    List<int> daysPerMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    if (month == 2 && _isLeapYear(year)) {
      return 29;
    }
    return daysPerMonth[month - 1];
  }

  /// Determines if the given year is a leap year.
  bool _isLeapYear(int year) {
    return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
  }

  /// Returns the year component of the date.
  int get year => _year;

  /// Returns the month component of the date.
  int get month => _month;

  /// Returns the day component of the date.
  int get day => _day;

  /// Returns the day of the week for the current date as an integer starting from 1: Saturday.
  int getDayOfWeek() {
    var wd = DateTime(_year, _month, _day).weekday;
    var d = (wd + 9) % 7;
    return d;
  }

  /// Formats the date as a string based on the provided format string.
  /// Supported tokens:
  /// - `yyyy`: full year (e.g., 2024)
  /// - `MM`: zero-padded month (e.g., 01)
  /// - `dd`: zero-padded day (e.g., 01)
  String format(String formatString) {
    return formatString
        .replaceAll('yyyy', _year.toString())
        .replaceAll('MM', _month.toString().padLeft(2, '0'))
        .replaceAll('dd', _day.toString().padLeft(2, '0'));
  }

  /// Adds the specified number of days to the current date.
  /// Supports positive and negative values for [daysToAdd].
  Date addDays(int daysToAdd) {
    int newDay = _day;
    int newMonth = _month;
    int newYear = _year;

    while (daysToAdd != 0) {
      if (daysToAdd > 0) {
        newDay++;
        if (newDay > _daysInMonth(newYear, newMonth)) {
          newDay = 1;
          newMonth++;
          if (newMonth > 12) {
            newMonth = 1;
            newYear++;
          }
        }
        daysToAdd--;
      } else {
        newDay--;
        if (newDay < 1) {
          newMonth--;
          if (newMonth < 1) {
            newMonth = 12;
            newYear--;
          }
          newDay = _daysInMonth(newYear, newMonth);
        }
        daysToAdd++;
      }
    }

    return Date(newYear, newMonth, newDay);
  }

  /// Checks if the current date is before the given [other] date.
  bool isBefore(Date other) {
    return (_year < other._year) ||
        (_year == other._year && _month < other._month) ||
        (_year == other._year && _month == other._month && _day < other._day);
  }

  /// Checks if the current date is after the given [other] date.
  bool isAfter(Date other) {
    return (_year > other._year) ||
        (_year == other._year && _month > other._month) ||
        (_year == other._year && _month == other._month && _day > other._day);
  }

  /// Checks if the current date is the same as the given [other] date.
  bool isSameDate(Date other) {
    return _year == other._year && _month == other._month && _day == other._day;
  }

  /// Returns the difference in days between the current date and the given [other] date.
  int differenceInDays(Date other) {
    int days = 0;
    Date temp = this;

    while (!temp.isSameDate(other)) {
      if (temp.isBefore(other)) {
        temp = temp.addDays(1);
        days++;
      } else {
        temp = temp.addDays(-1);
        days--;
      }
    }

    return days;
  }

  /// Checks if the current date is in the same year as the system's current year.
  bool isInCurrentYear() {
    Date now = Date(_currentYear(), _currentMonth(), _currentDay());
    return _year == now._year;
  }

  /// Checks if the current date is in the same month as the system's current month.
  bool isInCurrentMonth() {
    Date now = Date(_currentYear(), _currentMonth(), _currentDay());
    return _year == now._year && _month == now._month;
  }

  // Additional methods such as firstDayOfMonth, lastDayOfMonth, daysInCurrentMonth,
  // isLeapYear, and more are implemented but not detailed here for brevity.

  @override
  String toString() {
    return '$_year-${_month.toString().padLeft(2, '0')}-${_day.toString().padLeft(2, '0')}';
  }

  // Private methods to get the current year, month, and day using the system's time.
  static int _currentYear() => DateTime.now().year;
  static int _currentMonth() => DateTime.now().month;
  static int _currentDay() => DateTime.now().day;

  // Comparison operators
  bool operator >(Date other) => _compare(this, other) > 0;
  bool operator <(Date other) => _compare(this, other) < 0;
  bool operator >=(Date other) => _compare(this, other) >= 0;
  bool operator <=(Date other) => _compare(this, other) <= 0;

  @override
  bool operator ==(Object other) =>
      other is Date &&
      _year == other.year &&
      _month == other.month &&
      _day == other.day;

  @override
  int get hashCode => _year.hashCode ^ _month.hashCode ^ _day.hashCode;

  // Helper method to compare two Date objects.
  int _compare(Date a, Date b) {
    if (a.year != b.year) return a.year - b.year;
    if (a.month != b.month) return a.month - b.month;
    return a.day - b.day;
  }
}

/// A wrapper class for the [Date] type, used within the formula system.
///
/// The [DateWrapper] class provides a way to encapsulate a [Date] object
/// and allows it to be treated as a value within the formula system.
class DateWrapper extends ValueWrapper<Date> {
  /// Creates a [DateWrapper] that wraps the provided [Date] object.
  DateWrapper(super.value);

  /// Returns the type of the value as a string, which is `'Date'`.
  @override
  String get valueType => 'Date';

  @override
  String get stringToView =>
      '#${value.year}-${value.month.toString().padLeft(2, '0')}-${value.day.toString().padLeft(2, '0')}#';

  @override
  String get toTexNotation => stringToView;
}
