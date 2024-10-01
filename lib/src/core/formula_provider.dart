import '../../quds_formula_parser.dart';

/// A provider for managing formula terms, constants, variables, and functions.
///
/// The `FormulaProvider` class acts as a registry for handling various formula
/// components like constants, variables, and functions. It allows for the
/// insertion and retrieval of named values and supports function registration
/// for formula parsing and evaluation.
class FormulaProvider {
  FunctionIdentifier? _functionIdentifier;

  /// Sets the functions identifier for the formula provider.
  ///
  /// If the identifier is not already present in the list of identifiers, it
  /// will be added.
  void setFunctionsIdentifier(FunctionIdentifier functionsIdentifier) {
    _functionIdentifier = functionsIdentifier;
    if (!identifiers.contains(_functionIdentifier)) {
      identifiers.add(_functionIdentifier!);
    }
  }

  /// A list of formula term identifiers that can recognize different formula terms.
  ///
  /// Each identifier in this list is capable of recognizing and parsing a
  /// specific type of formula term, such as operators, constants, or functions.
  final List<FormulaTermIdentifier> identifiers = [];

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

  /// Inserts a constant into the provider.
  ///
  /// **Parameters**:
  /// - [constant]: The `Constant` to be added to the provider.
  ///
  /// **Returns**:
  /// - A `String?` containing an error message if the constant's symbol is already
  ///   used, otherwise `null` if successful.
  String? insertConstant(Constant constant) => _insertNamedValue(constant);

  /// Inserts a variable into the provider.
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

  /// Registers a function for formula evaluation.
  ///
  /// **Parameters**:
  /// - [notations]: A list of function notations (names or symbols).
  /// - [evaluator]: A function that performs the evaluation of the function.
  /// - [checkParameters]: (Optional) A function to validate parameters before evaluation.
  /// - [manipulateResult]: (Optional) A function to manipulate the result of the evaluation.
  ///
  /// **Returns**:
  /// - `true` if the function was successfully registered.
  bool registerFunction({
    required List<String> notations,
    required dynamic Function(Iterable<dynamic> parameters) evaluator,
    bool Function(Iterable<dynamic> parameters)? checkParameters,
    dynamic Function(dynamic result)? manipulateResult,
  }) {
    _ensureFunctionsIdentifierSet();
    var functionsIdentifier = _functionIdentifier!;
    functionsIdentifier.functions.add(FormulaFunctionRegister(
      functionNotations: notations,
      calculationsMethod: evaluator,
      manipulateOutput: manipulateResult,
      parametersCheckerMethod: checkParameters,
    ));
    return true;
  }

  /// Retrieves the default instance of the `FormulaProvider`.
  ///
  /// **Returns**:
  /// - A preconfigured instance of `FormulaProvider`.
  static FormulaProvider get defaultInstance => _generateDefaultProvider();

  // A map of named constants, where the key is the constant's symbol.
  final Map<String, Constant> _constants = {};

  // A map of named variables, where the key is the variable's symbol.
  final Map<String, Variable> _variables = {};

  // Ensures that the function identifier is set.
  void _ensureFunctionsIdentifierSet() {
    if (_functionIdentifier == null) {
      setFunctionsIdentifier(FunctionIdentifier(provider: this, functions: []));
    }
  }

  // Private method to insert a named value (constant or variable).
  String? _insertNamedValue(NamedValue nValue) {
    String name = nValue.symbol.trim().toLowerCase();
    if (_constants.containsKey(name)) {
      return 'There already exists a constant with the name ${nValue.symbol}';
    }

    if (_variables.containsKey(name)) {
      return 'There already exists a variable with the name ${nValue.symbol}';
    }

    for (var i in identifiers) {
      if (i is FunctionIdentifier) {
        for (var f in i.functions) {
          if (f.title.toLowerCase().trim() == name) {
            return 'There already exists a function with the name ${nValue.symbol}';
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
}

/// Generates a default instance of `FormulaProvider` with predefined identifiers and constants.
FormulaProvider _generateDefaultProvider() {
  FormulaProvider result = FormulaProvider();

  result.identifiers.addAll([
    ..._generateValueIdentifiers(),
    BracketIdentifier(),
    NamedValuesIdentifier(provider: result),
    FunctionIdentifier(
      provider: result,
      functions: _generateFunctionsIdenfiers(result),
    ),
    OperatorsIdentifiers(),
    CommaIdentifier(),
  ]);

  _registerAdditionalFunctions(result);
  _insertDefaultConstants(result);

  return result;
}

/// Inserts default mathematical constants (Pi and e) into the provided formula provider.
void _insertDefaultConstants(FormulaProvider provider) {
  for (var e in {
    'Pi': pi,
    'π': pi,
    'e': e,
    'ln10': ln10,
    'ln2': ln2,
    'log2e': log2e,
    'log10e': log10e,
    'sqrt1_2': sqrt1_2,
    'sqrt2': sqrt2,
  }.entries) {
    provider.insertConstant(
      Constant(symbol: e.key, value: RealNumberWrapper(e.value)),
    );
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
      FractionIdentifier(),
      ComplexNumberIdentifier(),
      RealNumberIdentifier(),
      Point2dIdentifier(),
      Point3dIdentifier()
    ];

/// Generates a list of function identifiers for various mathematical functions.
List<FormulaFunction> _generateFunctionsIdenfiers(FormulaProvider provider) => [
      ...CoreFunction.generateFunctions(provider),
      ...LogicalFunction.generateFunctions(),
    ];

/// Registers additional predefined functions into the provided formula provider.
void _registerAdditionalFunctions(FormulaProvider provider) {
  registerCoreFunctions(provider);
  registerMathmaticalFunctions(provider);
  registerTrigFunctions(provider);
  registerStatisticalFunctions(provider);
  registerGeometryFunctions(provider);
  registerAtomsFunctions(provider);
  registerStringFunctions(provider);
  registerDateTimeFunctions(provider);
  registerLogicalFunctions(provider);
  registerListsFunctions(provider);
  registerSetsFunctions(provider);
}
