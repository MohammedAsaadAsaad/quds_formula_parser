import 'package:quds_formula_parser/quds_formula_parser.dart';

/// A class to identify and parse time values in a formula.
///
/// This class identifies time strings in a specific format (enclosed in `#` symbols) and
/// converts them into [TimeWrapper] objects. The time format is expected to be in `HH:mm:ss`.
class TimeIdentifier extends ValueIdentifier<TimeWrapper> {
  /// Parses the input string to identify and extract a time.
  ///
  /// The expected format is a time string enclosed in `#` symbols, e.g., `#14:30:15#`.
  /// The string must follow the `HH:mm:ss` format.
  ///
  /// Returns a [TimeWrapper] object if the string is a valid time, or `null` if the input is invalid.
  @override
  TimeWrapper? parse(String str) {
    if (str.startsWith('#')) str = str.substring(1, str.length);
    if (str.endsWith('#')) str = str.substring(0, str.length - 1);

    var parts = str.split(':');
    int hour = int.parse(parts[0]);
    int minute = int.parse(parts[1]);
    int second = int.parse(parts[2]);

    return TimeWrapper(Time(hour, minute, second));
  }

  /// Returns the regular expression pattern used to identify time strings.
  ///
  /// The pattern matches time strings enclosed in `#` symbols, in the format `HH:mm:ss`.
  @override
  String get pattern {
    String twoDigits = r'[\d]{1,2}';
    var separator = r'[\:]';
    return '\\#$twoDigits$separator$twoDigits$separator$twoDigits\\#';
  }
}
