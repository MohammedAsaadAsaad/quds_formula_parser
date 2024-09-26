import 'package:quds_formula_parser/quds_formula_parser.dart';

/// A class representing a duration of time with days, hours, minutes, and seconds components.
class QudsDuration {
  final int days;
  final int hours;
  final int minutes;
  final int seconds;

  /// Constructs a [QudsDuration] with the given days, hours, minutes, and seconds.
  /// All parameters default to 0 if not provided.
  QudsDuration(
      {this.days = 0, this.hours = 0, this.minutes = 0, this.seconds = 0});

  /// Adds another [QudsDuration] to the current duration and returns the resulting [QudsDuration].
  QudsDuration add(QudsDuration other) {
    // Calculate the total seconds for both durations and return a new duration.
    int totalSeconds = toSeconds() + other.toSeconds();
    return fromSeconds(totalSeconds);
  }

  /// Converts the current [QudsDuration] into total seconds.
  ///
  /// The result is the total number of seconds represented by the days, hours, minutes, and seconds.
  int toSeconds() {
    return (days * 86400) + (hours * 3600) + (minutes * 60) + seconds;
  }

  /// Creates a [QudsDuration] from a total number of seconds.
  ///
  /// Converts the [totalSeconds] back into days, hours, minutes, and seconds.
  static QudsDuration fromSeconds(int totalSeconds) {
    int days = totalSeconds ~/ 86400;
    totalSeconds %= 86400;

    int hours = totalSeconds ~/ 3600;
    totalSeconds %= 3600;

    int minutes = totalSeconds ~/ 60;
    int seconds = totalSeconds % 60;

    return QudsDuration(
        days: days, hours: hours, minutes: minutes, seconds: seconds);
  }

  /// Returns a string representation of the [QudsDuration] in the format `Xd Xh Xm Xs`.
  @override
  String toString() {
    return '${days}d ${hours}h ${minutes}m ${seconds}s';
  }
}

/// A wrapper class for the [QudsDuration] type used within the formula system.
class QudsDurationWrapper extends ValueWrapper<QudsDuration> {
  /// Creates a [QudsDurationWrapper] that wraps a [QudsDuration] object.
  QudsDurationWrapper(super.value);

  /// Returns the type of the value as `'Duration'`.
  @override
  String get valueType => 'Duration';
}
