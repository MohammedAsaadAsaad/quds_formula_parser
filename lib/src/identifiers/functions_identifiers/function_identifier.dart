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

  /// HashMap for O(1) function lookup by notation (lowercase).
  final Map<String, FormulaFunction> _notationMap = {};

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

  /// Adds a function and updates the notation map for O(1) lookup.
  void addFunctionToMap(FormulaFunction function) {
    for (var notation in function.functionNotations) {
      _notationMap[notation.toLowerCase()] = function;
    }
  }

  /// Parses the input string to match it with a function's notation.
  ///
  /// Uses HashMap-based O(1) lookup instead of O(n*m) nested loop.
  /// If a function is added via [functions] list after initialization,
  /// the map is built lazily on first parse.
  ///
  /// **Parameters**:
  /// - [str]: The input string representing the function name.
  ///
  /// **Returns**:
  /// - The matching [FormulaFunction], or `null` if no match is found.
  @override
  FormulaFunction? parse(String str) {
    // Build map lazily if functions were added directly to the list
    if (_notationMap.isEmpty && functions.isNotEmpty) {
      for (var f in functions) {
        addFunctionToMap(f);
      }
    }

    return _notationMap[str.toLowerCase()];
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
