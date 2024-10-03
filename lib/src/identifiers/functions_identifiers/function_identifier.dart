import 'package:quds_formula_parser/quds_formula_parser.dart';
export 'math_functions/math_functions.dart';
export 'strings/string_functions.dart';
export 'logical/logical.dart';
export 'single_parameter_function.dart';
export 'datetime/datetime_functions.dart';
export 'core_functions/core_functions.dart';
export 'science/science.dart';
export 'iterables/iterables.dart';

/// A class to identify and parse function names in a formula.
///
/// This class matches function names from a list of available functions
/// and parses them based on their notations.
///
/// It is used to identify and retrieve the appropriate [FormulaFunction] based
/// on the input string.
class FunctionIdentifier extends FormulaTermIdentifier<FormulaFunction> {
  /// A list of available functions to identify from.
  final List<FormulaFunction> functions = [];

  /// The [FormulaProvider] that stores the functions.
  final FormulaProvider provider;

  /// Creates a [FunctionIdentifier] with the provided list of functions.
  ///
  /// **Parameters**:
  /// - [provider]: The formula provider managing the functions.
  /// - [functions]: A list of available [FormulaFunction] instances to be matched.
  FunctionIdentifier({required this.provider}) {
    provider.setFunctionsIdentifier(this);
  }

  /// Parses the input string to match it with a function's notation.
  ///
  /// Takes a string [str], converts it to lowercase, and compares it with the
  /// notations of the available functions. If a match is found, the corresponding
  /// [FormulaFunction] is returned. If no match is found, it returns `null`.
  ///
  /// **Parameters**:
  /// - [str]: The input string representing the function name.
  ///
  /// **Returns**:
  /// - The matching [FormulaFunction], or `null` if no match is found.
  @override
  FormulaFunction? parse(String str) {
    var s = str.toLowerCase();

    for (var f in functions) {
      for (var n in f.functionNotations) {
        if (n.toLowerCase() == s) return f;
      }
    }
    return null;
  }

  /// Returns the regular expression pattern used to identify function names.
  ///
  /// The pattern allows function names that start with an underscore or letter,
  /// followed by letters, numbers, or underscores. It also supports function
  /// names that may contain a dot for namespacing (e.g., `Math.Sin`).
  @override
  String get pattern {
    String varPattern = '[_a-zA-Z][_a-zA-Z0-9]*';
    return '^$varPattern(\\.$varPattern)?';
  }
}
