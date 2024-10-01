import 'package:quds_formula_parser/quds_formula_parser.dart';

/// Registers mathematical functions with the provided formula provider.
///
/// This function defines and registers a variety of mathematical operations, such as
/// basic arithmetic, trigonometric, and advanced functions like factorial, Fibonacci,
/// prime checks, and random number generation.
///
/// **Parameters**:
/// - [provider]: The `FormulaProvider` instance where the mathematical functions are registered.
void registerMathmaticalFunctions(FormulaProvider provider) {
  // Helper function to define single-parameter mathematical functions.
  void defineSingleParameter(
      List<String> notations, Function(dynamic a) calculationMethod,
      [bool inforceRealValue = true,
      bool Function(Iterable<dynamic>)? checkParameters]) {
    provider.registerFunction(
        notations: notations,
        evaluator: (params) => calculationMethod(params.first),
        checkParameters: checkParameters ??
            (params) =>
                params.isSingle && (!inforceRealValue || params.first is num));
  }

  // Helper function to define two-parameter mathematical functions.
  void defineCoupleOfParameter(
      List<String> notations, Function(dynamic a, dynamic b) calculationMethod,
      [bool Function(dynamic a, dynamic b)? checkParameters]) {
    provider.registerFunction(
        notations: notations,
        evaluator: (params) => calculationMethod(params.first, params.second),
        checkParameters: checkParameters != null
            ? (params) => (params.isCouple &&
                params.every((e) => e is num) &&
                checkParameters(params.first, params.second))
            : (params) => params.isCouple && params.every((e) => e is num));
  }

  // Define various single-parameter functions.
  defineSingleParameter(['Abs', 'Math.Abs', 'Absolute'], (v) {
    if (v is ComplexNumber) return v.abs;
    if (v is num) return v.abs();
    return null;
  }, false);

  defineSingleParameter(['Int', 'ToInt', 'ToInteger'], (v) => v.toInt());
  defineSingleParameter(['Floor', 'Math.Floor'], (v) => (v as num).floor());
  defineSingleParameter(['Ceiling', 'Math.Ceiling'], (v) => (v as num).ceil());

  defineSingleParameter(['SqRt', 'SqRoot', 'Math.Sqrt'], (v) => sqrt(v));
  defineSingleParameter(['Square', 'Math.Square'], (v) => pow(v, 2));
  defineSingleParameter(['Exp', 'Math.Exp'], (v) => exp(v));

  // Define trigonometric functions.
  defineSingleParameter(['Cosh'], (v) => cosh(v));
  defineSingleParameter(['Sinh'], (v) => sinh(v));
  defineSingleParameter(['Tanh'], (v) => tanh(v));

  // Define factorial, Fibonacci, and prime checking functions.
  defineSingleParameter(['Factorial', 'Math.Fact'], (v) => factorial(v), true,
      (params) => params.isSingle && params.first is int);
  defineSingleParameter(['Fibonacci', 'Math.Fib'], (v) => fibonacci(v), true,
      (params) => params.isSingle && params.first is int);
  defineSingleParameter(['IsPrime', 'Math.IsPrime'], (v) => isPrime(v), true,
      (params) => params.isSingle && params.first is int);

  // Define functions for checking even and odd numbers.
  defineSingleParameter(['IsEven', 'Math.IsEven'], (v) => (v as int).isEven,
      true, (params) => params.isSingle && params.first is int);
  defineSingleParameter(['IsOdd', 'Math.IsOdd'], (v) => (v as int).isOdd, true,
      (params) => params.isSingle && params.first is int);

  // Define functions for modulus, power, root, and hypotenuse calculations.
  defineCoupleOfParameter(['Mod', 'Modulus', 'Math.Mod'], (a, b) => a % b);
  defineCoupleOfParameter(['Pow', 'Power', 'Math.Pow'], (a, b) => pow(a, b));
  defineCoupleOfParameter(['Root', 'nthRoot', 'Math.Root'],
      (a, b) => pow(a, 1 / b), (a, b) => b is int);
  defineCoupleOfParameter(
      ['Hypo', 'Hypotenuse'], (a, b) => pow(0.5, pow(a, 2) + pow(b, 2)));

  // Register a round function.
  provider.registerFunction(
      notations: ['Round'],
      evaluator: (params) => params.isSingle
          ? (params.first as num).round()
          : ((params.first as num).toStringAsFixed(params.second)).toDouble(),
      checkParameters: (params) =>
          (params.first is num) &&
          (params.isSingle || (params.isCouple && params.second is int)));

  // Register a logarithm function.
  provider.registerFunction(
      notations: ['Log', 'Logarithm', 'Math.Log'],
      evaluator: (params) => params.isSingle
          ? log(params.first)
          : log(params.first) / log(params.second),
      checkParameters: (params) => params.isNotEmpty && params.length <= 2);

  // Register random integer and double generation functions.
  var random = Random();
  provider.registerFunction(
      notations: ['RandomInt', 'Random.Int'],
      evaluator: (params) {
        if (params.isSingle) return random.nextInt(params.first);
        int min = params.first;
        int max = params.second;
        return min + random.nextInt(max - min);
      },
      checkParameters: (params) =>
          (params.isSingle || params.isCouple) &&
          params.every((e) => e is int));

  provider.registerFunction(
      notations: ['RandomDouble', 'Random.Double'],
      evaluator: (params) {
        if (params.isEmpty) return random.nextDouble();
        num min = params.first;
        num max = params.second;
        return min + (random.nextDouble() * (max - min));
      },
      checkParameters: (params) =>
          params.isEmpty || (params.isCouple && params.every((e) => e is num)));

  // Define GCD and LCM functions.
  defineCoupleOfParameter(
      ['GCD', 'Math.GCD'], (a, b) => gcd(a, b), (a, b) => a is int && b is int);

  defineCoupleOfParameter(
      ['LCM', 'Math.LCM'], (a, b) => lcm(a, b), (a, b) => a is int && b is int);

  // Register a clamp function to constrain a value between min and max.
  provider.registerFunction(
      notations: ['Clamp', 'Math.Clamp'],
      evaluator: (params) => clamp(params.first, params.second, params.third),
      checkParameters: (params) =>
          params.isTriple && params.every((e) => e is num));
}
