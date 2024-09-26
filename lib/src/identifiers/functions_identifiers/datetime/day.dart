import 'package:quds_formula_parser/quds_formula_parser.dart';

/// A function that retrieves the day component from a date or datetime value.
///
/// This class extends [DateTimeFunction] and provides a method to extract
/// the day from a given date or datetime represented by a [DateWrapper] or
/// [QudsDateTimeWrapper].
class DayFunction extends DateTimeFunction {
  DayFunction() : super(functionNotations: ['Day']);

  @override
  calculate(List<ValueWrapper> parameters) {
    // Extract the first parameter
    var p = parameters.first;

    // Determine if the parameter is a DateWrapper or QudsDateTimeWrapper
    var d = p is DateWrapper
        ? p.value // If it's a DateWrapper, get the Date value
        : p is QudsDateTimeWrapper
            ? p.value.date // If it's a QudsDateTimeWrapper, get the Date part
            : null;

    // Return the day component or NAValue if not available
    return d?.day ?? NAValue();
  }

  @override
  bool checkParameters(List<ValueWrapper> terms) {
    // Ensure exactly one parameter is provided and it is either a date or datetime
    return terms.length == 1 && (terms.first.isDate || terms.first.isDateTime);
  }
}
