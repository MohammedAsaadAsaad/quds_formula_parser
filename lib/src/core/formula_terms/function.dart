import '../../../quds_formula_parser.dart';

/// An abstract class representing a formula function.
/// A `FormulaFunction` performs a calculation on a list of parameters and
/// returns a result of type `R`.
/// Subclasses should define specific functions with their own logic.
abstract class FormulaFunction<R> extends FormulaTerm {
  /// Constructs a `FormulaFunction` with the given notations.
  /// The `functionNotations` are the names or symbols used to represent the function.
  FormulaFunction({required this.functionNotations, this.manipulateOutput});

  /// Returns the title of the function, typically used to display the name or description.
  String get title => functionNotations.first;

  /// A list of alternative notations (symbols or names) that can represent the function.
  /// The first notation in this list is usually the primary representation.
  final List<String> functionNotations;

  /// This method should check if the provided parameters are valid for the function.
  /// It takes a list of `ValueWrapper` terms and performs validation.
  /// Returns `true` if the parameters are valid, otherwise returns `false`.
  bool checkParameters(List<ValueWrapper> terms);

  /// This method performs the calculation based on the given parameters
  /// and returns a result of type `R`.
  R calculate(List<ValueWrapper> parameters);

  final R Function(R value)? manipulateOutput;

  /// This method performs the calculation based on the given parameters
  /// with manipulation of the result
  /// and returns a result of type `R`.
  R calculateAndManipulate(List<ValueWrapper> parameters) {
    R result = calculate(parameters);
    if (manipulateOutput != null) {
      result = manipulateOutput!(result);
    }
    return result;
  }

  /// Returns the primary string representation of the function, which is
  /// the first notation in the `functionNotations` list.
  @override
  String get stringToView => functionNotations.first;
}
