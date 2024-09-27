import '../../../../../quds_formula_parser.dart';

class FractionIdentifier extends ValueIdentifier<FractionWrapper> {
  @override
  FractionWrapper parse(String str) {
    var pattern = _fractionPattern;
    var match = RegExp(pattern).firstMatchString(str)!;
    match = match.replaceAll('\\', '/');
    var parts = match.split('/');
    return FractionWrapper(Fraction(int.parse(parts[0]), int.parse(parts[1])));
  }

  late final String _fractionPattern = (() {
    var realNumPattern = RealNumberIdentifier().pattern;
    return '$realNumPattern(\\\\|\\/)$realNumPattern';
  }).call();

  @override
  String get pattern {
    String result = '(frac|f)\\($_fractionPattern\\)';
    return result;
  }
}
