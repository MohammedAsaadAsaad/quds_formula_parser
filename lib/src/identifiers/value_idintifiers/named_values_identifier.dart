import 'package:quds_formula_parser/quds_formula_parser.dart';

/// A class to identify and parse named values (constants or variables) in a formula.
///
/// This class identifies strings that represent either constants or variables, provided by a [FormulaProvider].
/// It checks the input string against the list of available constants and variables, and returns the corresponding [NamedValue].
class NamedValuesIdentifier extends FormulaTermIdentifier<NamedValue> {
  /// The [FormulaProvider] that supplies the constants and variables to match against.
  final FormulaProvider provider;

  /// Creates a [NamedValuesIdentifier] with the provided [FormulaProvider].
  NamedValuesIdentifier({required this.provider}) {
    provider.setNamedValuesIdentifier(this);
  }

  // A map of named constants, where the key is the constant's symbol.
  final Map<String, Constant> _constants = {};

  // A map of named variables, where the key is the variable's symbol.
  final Map<String, Variable> _variables = {};

  // Private method to insert a named value (constant or variable).
  String? _insertNamedValue(NamedValue nValue) {
    String name = nValue.symbol.trim().toLowerCase();
    if (_constants.containsKey(name)) {
      return 'There already exists a constant with the name ${nValue.symbol}';
    }

    if (_variables.containsKey(name)) {
      return 'There already exists a variable with the name ${nValue.symbol}';
    }

    var functionsIdentifier = provider.functionsIdentifier;
    if (functionsIdentifier != null) {
      var i = functionsIdentifier;
      for (var f in i.functions) {
        if (f.title.toLowerCase().trim() == name) {
          return 'There already exists a function with the name ${nValue.symbol}';
        }
      }
    }

    if (nValue is Variable) {
      _variables[name] = nValue;
    } else if (nValue is Constant) {
      _constants[name] = nValue;
    }

    return null;
  }

  /// Retrieves all constants stored in this provider.
  ///
  /// **Returns**:
  /// - An `Iterable<Constant>` containing all the constants in the provider.
  Iterable<Constant> get constants => _constants.values;

  /// Retrieves all variables stored in this provider.
  ///
  /// **Returns**:
  /// - An `Iterable<Variable>` containing all the variables in the provider.
  Iterable<Variable> get variables => _variables.values;

  /// Inserts a constant into the identifier.
  ///
  /// **Parameters**:
  /// - [constant]: The `Constant` to be added to the provider.
  ///
  /// **Returns**:
  /// - A `String?` containing an error message if the constant's symbol is already
  ///   used, otherwise `null` if successful.
  String? insertConstant(Constant constant) => _insertNamedValue(constant);

  /// Inserts a variable into the identifier.
  ///
  /// **Parameters**:
  /// - [variable]: The `Variable` to be added to the provider.
  ///
  /// **Returns**:
  /// - A `String?` containing an error message if the variable's symbol is already
  ///   used, otherwise `null` if successful.
  String? insertVariable(Variable variable) => _insertNamedValue(variable);

  /// Sets the value of a variable by its symbol.
  ///
  /// **Parameters**:
  /// - [symbol]: The symbol of the variable to be updated.
  /// - [value]: The new value to set for the variable.
  ///
  /// **Returns**:
  /// - `true` if the variable was successfully updated or created, `false` otherwise.
  bool setVariableValue(String symbol, dynamic value) {
    String key = symbol.toLowerCase().trim();
    if (!_variables.containsKey(key)) {
      insertVariable(Variable(symbol: symbol, value: toFormulaValue(value)));
    } else {
      _variables[key]!.value = toFormulaValue(value);
    }
    return true;
  }

  /// Parses the input string to identify and extract a named value.
  ///
  /// The string is compared to the available constants and variables (case-insensitive).
  /// If a match is found, the corresponding [NamedValue] is returned. If no match is found, it returns `null`.
  @override
  NamedValue? parse(String str) {
    var s = str.toLowerCase();
    return _constants[s] ?? _variables[s];
  }

  /// Returns the regular expression pattern used to identify named values.
  ///
  /// The pattern matches named values, including constants like `π` and variables using letters, underscores, and digits.
  @override
  String get pattern {
    String basePattern = r'\u0370-\u03FF\w\_';
    return '[$basePattern]+([$basePattern\\d]+)?';
  }
}
