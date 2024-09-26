import 'package:quds_formula_parser/quds_formula_parser.dart';

/// A class to identify and parse datetime values in a formula.
///
/// This class identifies datetime strings in a specific format (enclosed in `#` symbols) and
/// converts them into [QudsDateTimeWrapper] objects. The datetime format includes both a date
/// and a time component.
class QudsDateTimeIdentifier extends ValueIdentifier<QudsDateTimeWrapper> {
  /// Parses the input string to identify and extract a datetime.
  ///
  /// The expected format is a datetime string enclosed in `#` symbols, e.g., `#2024-09-25 14:30:15#`.
  /// The string can use `/` or `\` as separators for the date part. The time part is expected to
  /// be in the format `HH:mm:ss`. If the month or day is missing, they default to `1`.
  ///
  /// Returns a [QudsDateTimeWrapper] object if the string is a valid datetime, or `null` if the input is invalid.
  @override
  QudsDateTimeWrapper? parse(String str) {
    if (str.startsWith('#')) str = str.substring(1, str.length);
    if (str.endsWith('#')) str = str.substring(0, str.length - 1);

    var strParts = str.split(' ');
    var strDate = strParts[0];
    var strTime = strParts[1];

    // Replace different date separators with hyphens.
    strDate = strDate.replaceAll('\\', '-');
    strDate = strDate.replaceAll('/', '-');

    var dateParts = strDate.split('-');
    int year = int.parse(dateParts[0]);
    int month = dateParts.length == 1 ? 1 : int.parse(dateParts[1]);
    int day = dateParts.length == 1 ? 1 : int.parse(dateParts[2]);

    var timeParts = strTime.split(':');
    int hour = int.parse(timeParts[0]);
    int minute = int.parse(timeParts[1]);
    int second = int.parse(timeParts[2]);

    return QudsDateTimeWrapper(
        QudsDateTime(Date(year, month, day), Time(hour, minute, second)));
  }

  /// Returns the regular expression pattern used to identify datetime strings.
  ///
  /// The pattern matches datetime strings enclosed in `#` symbols, where the date and time are separated by a space.
  /// The date part allows optional separators (`-`, `/`, `\`) and supports dates with or without month and day components.
  /// The time part must be in the format `HH:mm:ss`.
  @override
  String get pattern {
    String fourDigits = r'[\d]{1,4}';
    String twoDigits = r'[\d]{1,2}';
    return '\\#$fourDigits([\\-\\/]$twoDigits[\\-\\/]$twoDigits)?\\ $twoDigits:$twoDigits:$twoDigits#';
  }
}
