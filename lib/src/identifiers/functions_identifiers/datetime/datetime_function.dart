import 'package:quds_formula_parser/quds_formula_parser.dart';

/// An abstract class representing functions related to date and time.
///
/// This class extends [FormulaFunction] and serves as a base for specific
/// date and time functions.
abstract class DateTimeFunction extends FormulaFunction {
  DateTimeFunction({required super.functionNotations});

  /// Generates a list of date and time functions.
  ///
  /// This method returns a list of specific date and time functions,
  /// including Today, Now, Date, Year, Month, Day, WeekDay, and Days.
  static List<DateTimeFunction> generateFunctions() => [
        TodayFunction(),
        NowFunction(),
        DateFunction(),
        YearFunction(),
        MonthFunction(),
        DayFunction(),
        WeekDayFunction(),
        DaysFunction(),
      ];
}
