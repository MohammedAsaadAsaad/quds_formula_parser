import 'package:quds_formula_parser/quds_formula_parser.dart';

/// An abstract class that provides support for organizing formula terms.
abstract class FormulaTermsSupporter {
  final Formula formula; // The formula that this supporter will organize.

  /// Constructs a [FormulaTermsSupporter] with the given [formula].
  FormulaTermsSupporter({required this.formula}) {
    if (!formula.hasParsingError) organize();
  }

  /// Organizes the terms of the formula.
  ///
  /// Returns a [FormulaSupporterResult] containing organized terms and messages.
  FormulaSupporterResult organize();

  ValueWrapper evaluate();
}

/// A result class containing the organized terms and any messages generated during the organization process.
class FormulaSupporterResult {
  final List<FormulaTerm> terms; // The organized list of formula terms.

  /// Constructs a [FormulaSupporterResult] with the given terms and messages.
  FormulaSupporterResult({required this.terms});
}
