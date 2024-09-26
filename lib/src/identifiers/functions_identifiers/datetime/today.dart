import 'package:quds_formula_parser/quds_formula_parser.dart';

/// A function that retrieves the current date.
///
/// This class extends [DateTimeFunction] and provides a method to return
/// the current date as a [DateWrapper].
class TodayFunction extends DateTimeFunction {
  TodayFunction() : super(functionNotations: ['Today']);

  @override
  FormulaValue calculate(List<ValueWrapper> parameters) {
    // Return the current date wrapped in a DateWrapper
    return DateWrapper(Date.now());
  }

  @override
  bool checkParameters(List<ValueWrapper> terms) {
    // This function does not require any parameters
    return terms.isEmpty;
  }
}
