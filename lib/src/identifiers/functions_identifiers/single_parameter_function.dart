import '../../../../quds_formula_parser.dart';

/// An abstract class for functions that take a single parameter and return a result.
///
/// This class serves as a base for functions that operate on one input and produce
/// an output. The input and output types are defined by the generic parameters [O] (output) and [P] (parameter).
///
/// Functions that extend this class must provide a calculation method and function title.
abstract class SingleParameterFunction<O, P>
    extends FormulaFunction<FormulaValue> {
  /// The method to calculate the result of the function using a single input.
  final O Function(P arg) calculationMethod;

  /// Creates a [SingleParameterFunction] with the provided notations, calculation method, and title.
  ///
  /// The `calculationMethod` defines how the function operates on the input parameter.
  /// The `functionTitle` specifies the name of the function.
  SingleParameterFunction({
    required super.functionNotations,
    required this.calculationMethod,
  });

  /// Calculates the result of applying the function to the given parameter.
  ///
  /// Takes a list of [ValueWrapper] parameters, where the first parameter is expected
  /// to be of type [P]. The result of the function is returned as a [FormulaValue].
  @override
  FormulaValue calculate(List<ValueWrapper> parameters) {
    var result = calculationMethod(parameters.first.value);
    return toFormulaValue(result);
  }

  /// Checks if the provided parameters are valid for the function.
  ///
  /// Validates that there is exactly one parameter.
  @override
  bool checkParameters(List<FormulaTerm> terms) {
    return terms.length == 1;
  }

  /// Returns the first function notation as the string representation to view.
  @override
  String get stringToView {
    return functionNotations.first;
  }
}
