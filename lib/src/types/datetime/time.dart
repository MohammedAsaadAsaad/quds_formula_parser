import 'package:quds_formula_parser/quds_formula_parser.dart';

/// A class representing time with hour, minute, and second components.
///
/// This class provides functionality for manipulating and comparing times, including
/// adding or subtracting seconds, formatting, and conversion between 12-hour and 24-hour formats.
class Time {
  final int _hour;
  final int _minute;
  final int _second;

  /// Creates a [Time] instance from a [DateTime] object.
  factory Time.fromDateTime(DateTime datetime) =>
      Time(datetime.hour, datetime.minute, datetime.second);

  /// Creates a [Time] instance representing the current time.
  factory Time.now() => Time.fromDateTime(DateTime.now());

  /// Constructs a [Time] object with the given hour, minute, and second, and validates the time.
  ///
  /// Throws [ArgumentError] if the time is invalid.
  Time(this._hour, this._minute, this._second) {
    if (!_isValidTime(_hour, _minute, _second)) {
      throw ArgumentError('Invalid time: $_hour:$_minute:$_second');
    }
  }

  /// Validates the time components (hour, minute, second).
  bool _isValidTime(int hour, int minute, int second) {
    return hour >= 0 &&
        hour < 24 &&
        minute >= 0 &&
        minute < 60 &&
        second >= 0 &&
        second < 60;
  }

  /// Returns the hour component of the time.
  int get hour => _hour;

  /// Returns the minute component of the time.
  int get minute => _minute;

  /// Returns the second component of the time.
  int get second => _second;

  /// Returns the total number of seconds since midnight.
  int totalSeconds() {
    return _hour * 3600 + _minute * 60 + _second;
  }

  /// Adds a specified number of [secondsToAdd] to the current time and returns a new [Time] object.
  Time addSeconds(int secondsToAdd) {
    int totalSec = totalSeconds() + secondsToAdd;
    int newHour = (totalSec ~/ 3600) % 24;
    int newMinute = (totalSec ~/ 60) % 60;
    int newSecond = totalSec % 60;
    return Time(newHour, newMinute, newSecond);
  }

  /// Subtracts a specified number of [secondsToSubtract] from the current time and returns a new [Time] object.
  Time subtractSeconds(int secondsToSubtract) {
    return addSeconds(-secondsToSubtract);
  }

  /// Checks if the current time is before the [other] time.
  bool isBefore(Time other) {
    return totalSeconds() < other.totalSeconds();
  }

  /// Checks if the current time is after the [other] time.
  bool isAfter(Time other) {
    return totalSeconds() > other.totalSeconds();
  }

  /// Checks if the current time is the same as the [other] time.
  bool isSameTime(Time other) {
    return _hour == other._hour &&
        _minute == other._minute &&
        _second == other._second;
  }

  /// Formats the time according to the specified [formatString].
  ///
  /// Supported tokens:
  /// - `HH`: hour (two digits)
  /// - `mm`: minute (two digits)
  /// - `ss`: second (two digits)
  String format(String formatString) {
    return formatString
        .replaceAll('HH', _hour.toString().padLeft(2, '0'))
        .replaceAll('mm', _minute.toString().padLeft(2, '0'))
        .replaceAll('ss', _second.toString().padLeft(2, '0'));
  }

  /// Converts the time to a 12-hour format string (e.g., '01:30 PM').
  String to12HourFormat() {
    int hour12 = _hour % 12;
    if (hour12 == 0) hour12 = 12; // Adjust 0 to 12
    String period = _hour < 12 ? 'AM' : 'PM';
    return '$hour12:${_minute.toString().padLeft(2, '0')} $period';
  }

  /// Returns the difference in seconds between this time and [other].
  int differenceInSeconds(Time other) {
    return totalSeconds() - other.totalSeconds();
  }

  /// Returns the difference between this time and [other] as a string in hours and minutes.
  String differenceInHrsMins(Time other) {
    int diff = differenceInSeconds(other);
    int hours = diff ~/ 3600;
    int minutes = (diff % 3600) ~/ 60;
    return '${hours.abs()} hours ${minutes.abs()} minutes';
  }

  /// Increments the current time by a specified number of [minutesToAdd] and returns a new [Time] object.
  Time incrementMinutes(int minutesToAdd) {
    return addSeconds(minutesToAdd * 60);
  }

  /// Decrements the current time by a specified number of [minutesToSubtract] and returns a new [Time] object.
  Time decrementMinutes(int minutesToSubtract) {
    return subtractSeconds(minutesToSubtract * 60);
  }

  /// Increments the current time by a specified number of [hoursToAdd] and returns a new [Time] object.
  Time incrementHours(int hoursToAdd) {
    return addSeconds(hoursToAdd * 3600);
  }

  /// Decrements the current time by a specified number of [hoursToSubtract] and returns a new [Time] object.
  Time decrementHours(int hoursToSubtract) {
    return subtractSeconds(hoursToSubtract * 3600);
  }

  /// Checks if this time is equal to [other].
  @override
  bool operator ==(Object other) {
    if (other is Time) {
      return isSameTime(other);
    }
    return false;
  }

  /// Returns a hash code for this time, combining the hour, minute, and second components.
  @override
  int get hashCode => _hour.hashCode ^ _minute.hashCode ^ _second.hashCode;

  /// Returns the string representation of the time in `HH:mm:ss` format.
  @override
  String toString() {
    return '${_hour.toString().padLeft(2, '0')}:${_minute.toString().padLeft(2, '0')}:${_second.toString().padLeft(2, '0')}';
  }

  // Comparison operators for comparing two Time objects.
  bool operator >(Time other) => totalSeconds() > other.totalSeconds();
  bool operator <(Time other) => totalSeconds() < other.totalSeconds();
  bool operator >=(Time other) => totalSeconds() >= other.totalSeconds();
  bool operator <=(Time other) => totalSeconds() <= other.totalSeconds();
}

/// A wrapper class for the [Time] type used within the formula system.
class TimeWrapper extends ValueWrapper<Time> {
  /// Creates a [TimeWrapper] that wraps a [Time] object.
  TimeWrapper(super.value);

  /// Returns the type of the value as `'Time'`.
  @override
  String get valueType => 'Time';

  @override
  String get toTexNotation =>
      '#${value.hour.toString().padLeft(2, '0')}:${value.minute.toString().padLeft(2, '0')}:${value.second.toString().padLeft(2, '0')}#';
}
