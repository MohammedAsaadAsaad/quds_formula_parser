import 'package:quds_formula_parser/quds_formula_parser.dart';

/// A class to identify and parse date values in a formula.
///
/// This class is responsible for identifying date strings in a specific format
/// (enclosed in `#` symbols) and converting them into [DateWrapper] objects.
class DateIdentifier extends ValueIdentifier<DateWrapper> {
  /// Parses the input string to identify and extract a date.
  ///
  /// The expected format is a date string enclosed in `#` symbols, e.g., `#2024-09-25#`.
  /// The string can also use `/` or `\` as separators. If the month or day is missing,
  /// they default to `1` (January or the 1st day of the month).
  ///
  /// Returns a [DateWrapper] object if the string is a valid date, or `null` if the input is invalid.
  @override
  DateWrapper? parse(String str) {
    if (str.startsWith('#')) str = str.substring(1, str.length);
    if (str.endsWith('#')) str = str.substring(0, str.length - 1);
    str = str.replaceAll('\\', '-');
    str = str.replaceAll('/', '-');
    var parts = str.split('-');
    int year = int.parse(parts[0]);
    int month = parts.length == 1 ? 1 : int.parse(parts[1]);
    int day = parts.length == 1 ? 1 : int.parse(parts[2]);
    return DateWrapper(Date(year, month, day));
  }

  /// Returns the regular expression pattern used to identify date strings.
  ///
  /// The pattern matches dates enclosed in `#` symbols, allowing optional separators (`-`, `/`, `\`)
  /// and supports dates with or without month and day components (e.g., `#2024#`, `#2024-09-25#`).
  @override
  String get pattern {
    String fourDigits = r'[\d]{1,4}';
    String twoDigits = r'[\d]{1,2}';
    return '\\#$fourDigits([\\-\\/]$twoDigits[\\-\\/]$twoDigits)?\\#';
  }
}
