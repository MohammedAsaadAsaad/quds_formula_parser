import '../../quds_formula_parser.dart';

/// A provider for managing formula terms, constants, and variables.
/// This class acts as a registry for different formula components
/// and provides functionalities to insert and retrieve named values.
class FormulaProvider {
  /// A list of formula term identifiers that can recognize different formula terms.
  final List<FormulaTermIdentifier> identifiers = [];

  /// A map of named constants, where the key is the constant's symbol.
  final Map<String, Constant> _constants = {};

  /// A map of named variables, where the key is the variable's symbol.
  final Map<String, Variable> _variables = {};

  /// Retrieves all constants stored in this provider.
  Iterable<Constant> get constants => _constants.values;

  /// Retrieves all variables stored in this provider.
  Iterable<Variable> get variables => _variables.values;

  /// Inserts a constant into the provider.
  /// Returns an error message if the constant's symbol is already used.
  String? insertConstant(Constant constant) => _insertNamedValue(constant);

  /// Inserts a variable into the provider.
  /// Returns an error message if the variable's symbol is already used.
  String? insertVariable(Variable variable) => _insertNamedValue(variable);

  /// Sets the value of a variable by its symbol.
  /// Returns `false` if the variable does not exist, `true` otherwise.
  bool setVariableValue(String symbol, dynamic value) {
    String key = symbol.toLowerCase().trim();
    if (!_variables.containsKey(key)) {
      insertVariable(Variable(symbol: symbol, value: toFormulaValue(value)));
    } else {
      _variables[key]!.value = toFormulaValue(value);
    }
    return true;
  }

  /// Private method to insert a named value (constant or variable).
  /// Returns an error message if the name is already taken by another
  /// constant, variable, or function.
  String? _insertNamedValue(NamedValue nValue) {
    String name = nValue.symbol.trim().toLowerCase();
    if (_constants.containsKey(name)) {
      return 'There already constant with the name ${nValue.symbol}';
    }

    if (_variables.containsKey(name)) {
      return 'There already variable with the name ${nValue.symbol}';
    }

    for (var i in identifiers) {
      if (i is FunctionIdentifier) {
        for (var f in i.functions) {
          if (f.title.toLowerCase().trim() == name) {
            return 'There already function with the name ${nValue.symbol}';
          }
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

  /// Singleton instance of the default `FormulaProvider`.
  static final FormulaProvider _instance = _generateDefaultProvider();

  /// Retrieves the default instance of the `FormulaProvider`.
  static FormulaProvider get defaultInstance => _instance;
}

/// Generates a default instance of `FormulaProvider` with predefined identifiers and constants.
FormulaProvider _generateDefaultProvider() {
  FormulaProvider result = FormulaProvider();

  result.identifiers.addAll([
    ..._generateValueIdentifiers(),
    BracketIdentifier(),
    NamedValuesIdentifier(provider: result),
    FunctionIdentifier(functions: _generateFunctionsIdenfiers(result)),
    OperatorsIdentifiers(),
    CommaIdentifier(),
  ]);

  _insertDefaultConstants(result);

  return result;
}

/// Inserts default mathematical constants (Pi and e) into the provided formula provider.
void _insertDefaultConstants(FormulaProvider provider) {
  for (var e in {'Pi': pi, 'π': pi, 'e': e}.entries) {
    provider.insertConstant(
        Constant(symbol: e.key, value: RealNumberWrapper(e.value)));
  }
}

/// Generates a list of value identifiers for different types of values.
List<ValueIdentifier> _generateValueIdentifiers() => [
      TimeIdentifier(),
      DateIdentifier(),
      QudsDateTimeIdentifier(),
      AtomIdentifier(),
      StringIdentifier(),
      BooleanIdentifier(),
      ComplexNumberIdentifier(),
      RealNumberIdentifier(),
      Point2dIdentifier(),
      Point3dIdentifier()
    ];

/// Generates a list of function identifiers for various mathematical functions.
List<FormulaFunction> _generateFunctionsIdenfiers(FormulaProvider provider) => [
      ...CoreFunction.generateFunctions(provider),
      ...RealFunction.generateFunctions(),
      ...GeometryFunction.generateFunction(),
      ...ListFunction.generateFunctions(),
      ...LogicalFunction.generateFunctions(),
      ...TriangleFunctionSingleParameter.generateFunctions(),
      ...StringFunction.generateFunctions(),
      ...DateTimeFunction.generateFunctions(),
      ...ScienceFunction.generateFunctions(),
    ];
