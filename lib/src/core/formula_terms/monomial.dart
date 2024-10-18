import 'package:quds_formula_parser/quds_formula_parser.dart';

class Monomial extends FormulaTerm {
  final RealNumberWrapper coefficient;
  final NamedValue namedValue;
  final RealNumberWrapper exponent;

  Monomial(
      {required this.coefficient,
      required this.namedValue,
      required this.exponent});

  @override
  String get stringToView {
    // Handle special cases for string representation
    if (coefficient.value == 0) return "0";
    String result = '';

    // Handle coefficients
    if (coefficient.value == 1) {
      result = namedValue.stringToView;
    } else if (coefficient.value == -1) {
      result = '-${namedValue.stringToView}';
    } else {
      result = '${coefficient.stringToView}*${namedValue.stringToView}';
    }

    // Add exponent if it's not 1
    if (exponent.value != 1) {
      result += '^${exponent.stringToView}';
    }
    return result;
  }

  // Check if two monomials are "like terms" (same namedValue and exponent)
  bool likes(Monomial other) =>
      namedValue.symbol == other.namedValue.symbol &&
      exponent.value == other.exponent.value;

  // Combine like terms by adding their coefficients
  Monomial combine(Monomial other) {
    if (!likes(other)) {
      throw ArgumentError(
          'Cannot combine monomials with different named values or exponents.');
    }

    return Monomial(
      coefficient:
          RealNumberWrapper(coefficient.value + other.coefficient.value),
      namedValue: namedValue,
      exponent: exponent,
    );
  }

  // Override equality to compare monomials directly
  @override
  bool operator ==(Object other) =>
      other is Monomial &&
      namedValue.symbol == other.namedValue.symbol &&
      exponent.value == other.exponent.value &&
      coefficient.value == other.coefficient.value;

  @override
  int get hashCode =>
      coefficient.value.hashCode ^
      namedValue.symbol.hashCode ^
      exponent.value.hashCode;

  @override
  String get toTexNotation => '';
}
