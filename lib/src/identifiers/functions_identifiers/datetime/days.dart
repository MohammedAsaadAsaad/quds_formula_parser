import 'package:quds_formula_parser/quds_formula_parser.dart';

/// A function that calculates the number of days between two dates.
///
/// This class extends [DateTimeFunction] and provides a method to compute
/// the difference in days between two given dates represented by
/// [DateWrapper] or [QudsDateTimeWrapper].
class DaysFunction extends DateTimeFunction {
  DaysFunction() : super(functionNotations: ['Days']);

  @override
  calculate(List<ValueWrapper> parameters) {
    // Extract the first and second parameters
    var p1 = parameters[0];
    var p2 = parameters[1];

    // Determine if the first parameter is a DateWrapper or QudsDateTimeWrapper
    var d1 = p1 is DateWrapper
        ? p1.value // Get the Date value if it's a DateWrapper
        : p1 is QudsDateTimeWrapper
            ? p1.value.date // Get the Date part if it's a QudsDateTimeWrapper
            : null;

    // Determine if the second parameter is a DateWrapper or QudsDateTimeWrapper
    var d2 = p2 is DateWrapper
        ? p2.value // Get the Date value if it's a DateWrapper
        : p2 is QudsDateTimeWrapper
            ? p2.value.date // Get the Date part if it's a QudsDateTimeWrapper
            : null;

    // Return NAValue if either date is not available
    if (d1 == null || d2 == null) return NAValue();

    // Calculate and return the difference in days
    return d2.differenceInDays(d1);
  }

  @override
  bool checkParameters(List<ValueWrapper> terms) {
    // Ensure exactly two parameters are provided and both are dates or datetimes
    return terms.length == 2 &&
        (terms.first.isDate || terms.first.isDateTime) &&
        (terms[1].isDate || terms[1].isDateTime);
  }
}
