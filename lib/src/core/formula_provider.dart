import '../../quds_formula_parser.dart';

/// A provider for managing formula terms, constants, variables, and functions.
///
/// The `FormulaProvider` class acts as a registry for handling various formula
/// components like constants, variables, and functions. It allows for the
/// insertion and retrieval of named values and supports function registration
/// for formula parsing and evaluation.
class FormulaProvider {
  FunctionIdentifier? _functionIdentifier;
  FunctionIdentifier? get functionsIdentifier => _functionIdentifier;
  NamedValuesIdentifier? _namedValuesIdentifier;
  NamedValuesIdentifier get namedValuesIdentifier {
    _namedValuesIdentifier ??= NamedValuesIdentifier(provider: this);
    return _namedValuesIdentifier!;
  }

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

  /// Sets the named values (constants, variables) identifier for the formula provider.
  ///
  /// If the identifier is not already present in the list of identifiers, it
  /// will be added.
  void setNamedValuesIdentifier(NamedValuesIdentifier namedValuesIdentifier) {
    _namedValuesIdentifier = namedValuesIdentifier;
    if (!identifiers.contains(_namedValuesIdentifier)) {
      identifiers.add(_namedValuesIdentifier!);
    }
  }

  /// A list of formula term identifiers that can recognize different formula terms.
  ///
  /// Each identifier in this list is capable of recognizing and parsing a
  /// specific type of formula term, such as operators, constants, or functions.
  final List<FormulaTermIdentifier> identifiers = [];

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

  // Ensures that the function identifier is set.
  void _ensureFunctionsIdentifierSet() {
    if (_functionIdentifier == null) {
      setFunctionsIdentifier(FunctionIdentifier(provider: this));
    }
  }

  bool setVariableValue(String symbol, dynamic value) =>
      namedValuesIdentifier.setVariableValue(symbol, value);

  /// Inserts a constant into the identifier.
  ///
  /// **Parameters**:
  /// - [constant]: The `Constant` to be added to the provider.
  ///
  /// **Returns**:
  /// - A `String?` containing an error message if the constant's symbol is already
  ///   used, otherwise `null` if successful.
  String? insertConstant(Constant constant) =>
      namedValuesIdentifier.insertConstant(constant);

  /// Inserts a variable into the identifier.
  ///
  /// **Parameters**:
  /// - [variable]: The `Variable` to be added to the provider.
  ///
  /// **Returns**:
  /// - A `String?` containing an error message if the variable's symbol is already
  ///   used, otherwise `null` if successful.
  String? insertVariable(Variable variable) =>
      namedValuesIdentifier.insertVariable(variable);
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
    )..functions.addAll(_generateFunctionsIdenfiers(result)),
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
