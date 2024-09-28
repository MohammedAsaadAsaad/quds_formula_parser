import 'package:quds_formula_parser/quds_formula_parser.dart';

/// A function that constructs a date from year, month, and day values.
///
/// This class extends [DateTimeFunction] and implements a function
/// to create a date represented by a [DateWrapper].
class DateFunction extends DateTimeFunction {
  DateFunction() : super(functionNotations: ['Date']);

  @override
  FormulaValue calculate(List<ValueWrapper> parameters) {
    // Extract year, month, and day from parameters
    int year = parameters.first.value;
    int month =
        parameters.length > 1 ? parameters[1].value : 1; // Default month to 1
    int day =
        parameters.length > 2 ? parameters[2].value : 1; // Default day to 1

    // Return a DateWrapper with the constructed Date
    return DateWrapper(Date(year, month, day));
  }

  @override
  bool checkParameters(List<ValueWrapper> terms) {
    // Ensure the number of parameters is between 1 and 3
    if (terms.isEmpty || terms.length > 3) return false;

    // Validate that all parameters are real numbers
    return terms.every((e) => e.isRealNumber);
  }
}
