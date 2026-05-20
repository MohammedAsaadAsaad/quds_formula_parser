import '../../quds_formula_parser.dart';

/// A parser for processing formulas using the specified `FormulaProvider`.
/// This class is responsible for interpreting the string representation of formulas
/// and breaking them down into their constituent terms.
class FormulaParser<T extends FormulaTermsSupporter> {
  /// Creates an instance of `FormulaParser` with the provided formula provider.
  FormulaParser({
    FormulaProvider? provider,
  }) {
    _provider = provider ?? FormulaProvider.defaultInstance;
    internalSupporterFactory =
        (f) => FormulaInfixToPostfixConvertor(formula: f) as T;
  }
  late T Function(Formula formula) internalSupporterFactory;

  factory FormulaParser.defaultParser() =>
      FormulaParser(provider: FormulaProvider.defaultInstance);

  /// The `FormulaProvider` instance that contains identifiers for parsing terms.
  FormulaProvider? _provider;

  /// Get the current provider of this parser
  FormulaProvider get provider {
    _provider ??= FormulaProvider.defaultInstance;
    return _provider!;
  }

  /// Inserts a variable into the provider.
  /// Returns an error message if the variable's symbol is already used.
  String? insertVariable(NamedValue variable) =>
      provider.insertVariable(variable);

  /// Inserts a constant into the provider.
  /// Returns an error message if the constant's symbol is already used.
  String? insertConstant(NamedValue constant) =>
      provider.insertConstant(constant);

  /// Set a value of a variable
  bool setVariableValue(String symbol, [value]) =>
      provider.setVariableValue(symbol, value);

  /// Set a collection of variables
  bool setVariables(Map<String, dynamic> variables) {
    for (var e in variables.entries) {
      if (!setVariableValue(e.key, e.value)) return false;
    }
    return true;
  }

  set provider(FormulaProvider provider) => _provider = provider;

  /// Parses a formula represented as a string and returns a `Formula` object.
  /// This method processes the string and identifies terms, values, and functions.
  Formula parse(String str) {
    if (formula != null && formula!.formulaString.trim() == str) {
      return formula!;
    }
    str = str.trim(); // Remove leading and trailing whitespace

    Formula result = Formula(parser: this); // Initialize the formula object
    int position = 0; // Track current position in input string

    while (position < str.length) {
      // Skip whitespace
      while (position < str.length && str[position] == ' ') {
        position++;
      }

      if (position >= str.length) break; // Exit if we've consumed all input

      // Get substring from current position for identifier matching
      String remaining = str.substring(position);
      bool found = false;

      // Parse values
      for (var id in provider.identifiers) {
        var r = id.getMatchString(remaining); // Attempt to match a term
        if (r != null) {
          var parsed = id.parse(r); // Parse the matched term
          if (parsed != null) {
            result.terms.add(parsed
              ..position = position); // Add the parsed term to the formula
            position += r.length; // Update position
            found = true; // Mark that a term was found
            break; // Exit the loop since a term was found
          }
        }
      }

      if (!found) {
        // No matching term found
        result.errorParsingPosition = position;
        result.errorCode = FormulaErrorCode.undefinedTerm;
        break;
      }
    }

    _currentFormula = result.hasParsingError ? null : result;

    _internalSupporter = _currentFormula == null
        ? null
        : internalSupporterFactory(_currentFormula!);

    return result; // Return the parsed formula
  }

  Formula? _currentFormula;
  Formula? get formula => _currentFormula;
  T? _internalSupporter;
  ValueWrapper evaluate() {
    if (_currentFormula == null) return NullValue();
    return _internalSupporter!.evaluate();
  }
}
