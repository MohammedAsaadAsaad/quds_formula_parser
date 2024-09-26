import 'package:quds_formula_parser/quds_formula_parser.dart';

/// A function that retrieves the month from a given date.
///
/// This class extends [DateTimeFunction] and provides a method to extract
/// the month from a given date represented by [DateWrapper] or
/// [QudsDateTimeWrapper].
class MonthFunction extends DateTimeFunction {
  MonthFunction() : super(functionNotations: ['Month']);

  @override
  calculate(List<ValueWrapper> parameters) {
    // Extract the first parameter
    var p = parameters.first;

    // Determine if the parameter is a DateWrapper or QudsDateTimeWrapper
    var d = p is DateWrapper
        ? p.value // Get the Date value if it's a DateWrapper
        : p is QudsDateTimeWrapper
            ? p.value.date // Get the Date part if it's a QudsDateTimeWrapper
            : null;

    // Return the month if the date is valid; otherwise, return NAValue
    return d?.month ?? NAValue();
  }

  @override
  bool checkParameters(List<ValueWrapper> terms) {
    // Ensure exactly one parameter is provided and it is a date or datetime
    return terms.length == 1 && (terms.first.isDate || terms.first.isDateTime);
  }
}
