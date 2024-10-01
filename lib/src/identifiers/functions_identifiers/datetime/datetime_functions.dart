import 'package:quds_formula_parser/quds_formula_parser.dart';

/// Registers Date and Time-related functions with the provided formula provider.
///
/// This function defines and registers functions that operate on `Date`, `Time`,
/// and `QudsDateTime` objects, such as extracting the year, month, day, hour, minute,
/// and second, as well as calculating the difference in days between two dates.
///
/// **Parameters**:
/// - [provider]: The `FormulaProvider` instance where the date and time functions are registered.
void registerDateTimeFunctions(FormulaProvider provider) {
  // Converts a `QudsDateTime` or `Date` to `Date`.
  Date toDate(dynamic d) => (d is QudsDateTime) ? d.date : d;

  // Converts a `QudsDateTime` or `Time` to `Time`.
  Time toTime(dynamic d) => (d is QudsDateTime) ? d.time : d;

  // Defines and registers a date-related function with the given notations and calculation method.
  void defineDateFunction(
      List<String> notations, Function(Date d) calculationMethod) {
    provider.registerFunction(
        notations: notations,
        evaluator: (params) {
          return calculationMethod(toDate(params.first));
        },
        checkParameters: (params) =>
            params.isSingle &&
            (params.first is Date || params.first is QudsDateTime));
  }

  // Defines and registers a time-related function with the given notations and calculation method.
  void defineTimeFunction(
      List<String> notations, Function(Time t) calculationMethod) {
    provider.registerFunction(
        notations: notations,
        evaluator: (params) {
          return calculationMethod(toTime(params.first));
        },
        checkParameters: (params) =>
            params.isSingle &&
            (params.first is Date || params.first is QudsDateTime));
  }

  // Registers functions to extract the year, month, day, and weekday from a date.
  defineDateFunction(['Year', 'Date.Year'], (d) => d.year);
  defineDateFunction(['Month', 'Date.Month'], (d) => d.month);
  defineDateFunction(['Day', 'Date.Day'], (d) => d.day);
  defineDateFunction(['WeekDay', 'Date.WeekDay'], (d) => d.getDayOfWeek());

  // Registers functions to extract the hour, minute, and second from a time.
  defineTimeFunction(['Hour', 'Time.Hour'], (d) => d.hour);
  defineTimeFunction(['Minute', 'Time.Minute'], (d) => d.minute);
  defineTimeFunction(['Second', 'Time.Second'], (d) => d.second);

  /// Registers a `Date` function to create a date from year, month, and day.
  provider.registerFunction(
      notations: ['Date'],
      evaluator: (params) {
        return Date(params.first, params.length >= 2 ? params.second : 1,
            params.length >= 3 ? params.third : 1);
      },
      checkParameters: (params) =>
          params.length <= 3 && params.every((e) => e is int));

  /// Registers a `Days` function to calculate the difference in days between two dates.
  provider.registerFunction(
      notations: ['Days'],
      evaluator: (params) {
        Date d1 = toDate(params.first);
        Date d2 = toDate(params.second);
        return d1.differenceInDays(d2);
      },
      checkParameters: (params) =>
          params.length == 2 &&
          params.every((e) => e is Date || e is QudsDateTime));

  /// Registers a `Now` function to get the current time.
  provider.registerFunction(
      notations: ['Now'],
      evaluator: (params) {
        return Time.fromDateTime(DateTime.now());
      },
      checkParameters: (params) => params.isEmpty);

  /// Registers a `Today` function to get the current date.
  provider.registerFunction(
      notations: ['Today'],
      evaluator: (params) {
        return Date.fromDateTime(DateTime.now());
      },
      checkParameters: (params) => params.isEmpty);
}
