import 'package:quds_formula_parser/quds_formula_parser.dart';

/// A function that retrieves the day of the week for a given date.
///
/// This class extends [DateTimeFunction] and provides a method to return
/// the day of the week as an integer, where 1 represents Sunday and 7 represents Saturday.
class WeekDayFunction extends DateTimeFunction {
  WeekDayFunction() : super(functionNotations: ['WeekDay']);

  @override
  calculate(List<ValueWrapper> parameters) {
    // Extract the date from the parameters
    var p = parameters.first;
    var d = p is DateWrapper
        ? p.value // If it's a DateWrapper, get the date value
        : p is QudsDateTimeWrapper
            ? p.value.date // If it's a QudsDateTimeWrapper, get the date value
            : null;

    // Return the day of the week or NAValue if the date is null
    return d?.getDayOfWeek() ?? NAValue();
  }

  @override
  bool checkParameters(List<ValueWrapper> terms) {
    // Check that there is exactly one parameter and it is a date or datetime
    return terms.length == 1 && (terms.first.isDate || terms.first.isDateTime);
  }
}
