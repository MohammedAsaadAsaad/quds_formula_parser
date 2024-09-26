import 'package:quds_formula_parser/quds_formula_parser.dart';

/// A function that retrieves the current date and time.
///
/// This class extends [DateTimeFunction] and provides a method to return
/// the current date and time as a [TimeWrapper].
class NowFunction extends DateTimeFunction {
  NowFunction() : super(functionNotations: ['Now']);

  @override
  FormulaValue calculate(List<ValueWrapper> parameters) {
    // Return the current date and time wrapped in a TimeWrapper
    return TimeWrapper(Time.now());
  }

  @override
  bool checkParameters(List<ValueWrapper> terms) {
    // This function does not require any parameters
    return terms.isEmpty;
  }
}
