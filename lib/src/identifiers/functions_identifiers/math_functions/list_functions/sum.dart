import 'package:quds_formula_parser/quds_formula_parser.dart';

/// A function to calculate the sum of a list of values.
///
/// This function computes the sum of the provided parameters. If the list is empty,
/// it returns [NullValue]. If there's only one parameter, it returns that parameter.
/// Otherwise, it sums the values using the [AddOperator].
///
/// Function notations:
/// - 'Sum'
/// - 'Math.Sum'
class SumFunction extends ListFunction {
  /// Creates an instance of [SumFunction] with the notations 'Sum' and 'Math.Sum'.
  SumFunction()
      : super(functionNotations: [
          'Sum',
          'Math.Sum',
          'Summation',
        ]);

  /// Calculates the sum of the given parameters.
  ///
  /// Takes a list of [ValueWrapper] parameters. If the list is empty, it returns
  /// [NullValue]. If there's only one parameter, it returns that parameter.
  /// Otherwise, it iterates through the parameters and computes the sum
  /// using an instance of [AddOperator]. If any intermediate result is
  /// [NAValue] or [NullValue], it returns the corresponding value.
  @override
  calculate(List<ValueWrapper> parameters) {
    if (parameters.isEmpty) return NullValue();

    if (parameters.length == 1) return parameters.first;
    var addOperator = AddOperator();

    var result = addOperator.calculate(parameters[0], parameters[1]);
    for (int i = 2; i < parameters.length; i++) {
      if (result.isNAValue) return NAValue();
      if (result.isNull) return NullValue();
      result = addOperator.calculate(result, parameters[i]);
    }
    return result;
  }

  /// Checks if the provided parameters are valid for summation.
  ///
  /// Validates that the number of parameters is not empty. Returns true
  /// if there is at least one parameter, otherwise false.
  @override
  bool checkParameters(List<FormulaTerm> terms) {
    return terms.isNotEmpty;
  }
}
