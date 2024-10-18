import 'dart:collection';
import 'package:quds_formula_parser/quds_formula_parser.dart';

/// A class that completes formulas by inserting implied multiplication and
/// handling missing values.
///
/// This class extends [FormulaTermsSupporter] and ensures that the formula
/// terms are complete for evaluation by inserting necessary operators or values.
class FormulaTermsCompleter extends FormulaTermsSupporter {
  FormulaTermsCompleter({required super.formula});

  /// Organizes the formula terms to ensure completeness.
  ///
  /// This method scans through the terms of the formula and inserts implied
  /// multiplication operators and default values where necessary, returning
  /// a [FormulaSupporterResult] containing the organized terms and any messages
  /// that may have occurred during the process.
  @override
  FormulaSupporterResult organize() {
    List<FormulaTerm> terms = [];
    _completeFormula();
    if (_checkTerms()) {
      FormulaSimplifier(formula: formula).organize();
    }
    return FormulaSupporterResult(terms: terms);
  }

  bool _checkTerms() {
    FormulaErrorInTerms? result;
    var checkers = [
      _checkBrackets,
      _checkOperands,
      _checkEmptyBrackets,
    ];

    for (var c in checkers) {
      var r = c.call();
      if (r != null) {
        result = r;
        break;
      }
    }

    if (result != null) {
      formula.errorParsingPosition = result.position;
      formula.errorCode = result.errorType;
    }
    return result == null;
  }

  FormulaErrorInTerms? _checkOperands() {
    for (int i = 0; i < formula.terms.length; i++) {
      var term = formula.terms[i];

      // Check if the term is an operator
      if (term.isOperator) {
        // Check for missing left operand
        if (i == 0 ||
            formula.terms[i - 1].isOperator ||
            formula.terms[i - 1].isLeftBracket) {
          return FormulaErrorInTerms(
              position: term.position!,
              errorType: FormulaErrorCode.missingLeftOperand);
        }

        // Check for missing right operand
        if (i == formula.terms.length - 1 ||
            formula.terms[i + 1].isOperator ||
            formula.terms[i + 1].isRightBracket) {
          return FormulaErrorInTerms(
              position: term.position!,
              errorType: FormulaErrorCode.missingRightOperand);
        }
      }
    }
    return null;
  }

  FormulaErrorInTerms? _checkEmptyBrackets() {
    for (int i = 0; i < formula.terms.length - 1; i++) {
      var term = formula.terms[i];
      if (i > 0 && formula.terms[i - 1].isFunction) continue;

      if (term.isOpeningBracket && formula.terms[i + 1].isClosingBracket) {
        return FormulaErrorInTerms(
            position: term.position!,
            errorType: FormulaErrorCode.emptyBrackets);
      }
    }
    return null;
  }

  FormulaErrorInTerms? _checkBrackets() {
    Queue<FormulaTerm> checker = Queue();

    for (var t in formula.terms) {
      if (t.isOpeningBracket) {
        checker.addLast(t);
      } else if (t.isClosingBracket) {
        if (checker.isEmpty) {
          return FormulaErrorInTerms(
              position: t.position!,
              errorType: FormulaErrorCode.missingOpeningBracket);
        } else {
          checker.removeLast();
        }
      }
    }

    if (checker.isNotEmpty) {
      return FormulaErrorInTerms(
          position: checker.last.position!,
          errorType: FormulaErrorCode.missingClosingBracket);
    }
    return null;
  }

  /// Completes the formula by inserting implicit multiplication and handling
  /// missing values.
  ///
  /// This method scans through the terms of the formula, checking for patterns
  /// that require the insertion of multiplication operators (e.g., between a
  /// variable or constant and a left bracket, or between two consecutive values).
  /// It also adds a zero when there is a leading operator or when an operator
  /// follows an opening bracket.
  void _completeFormula() {
    if (formula.hasParsingError) return;

    int size = formula.terms.length;
    for (int i = 0; i < size; i++) {
      var t1 = formula.terms[i];
      if (t1.isValue || t1.isNamedValue || t1.isRightBracket) {
        if (i < size - 1) {
          var t2 = formula.terms[i + 1];
          if (t2.isNamedValue || t2.isLeftBracket || t2.isFunction) {
            // Insert multiplication operator if followed by a variable, constant, left bracket, or function
            formula.terms.insert(i + 1, MultiplyOperator());
            size++;
          }
        }
      }

      if (t1.isOperator && (t1 is AddOperator || t1 is SubtractOperator)) {
        if (i > 0) {
          var prev = formula.terms[i - 1];
          // Add a default value of 0 if the previous term is a left bracket
          if (prev.isLeftBracket) {
            formula.terms.insert(i, RealNumberWrapper(0));
            formula.terms.insert(i, OpeningBracket());
            formula.terms.insert(i + 4, ClosingBracket());
            size += 3;
          }
        } else {
          // Insert a default value of 0 at the start if the operator is the first term
          formula.terms.insert(0, RealNumberWrapper(0));
          size++;
        }
      }
    }
  }

  @override
  evaluate() => NullValue();
}

class FormulaErrorInTerms {
  final FormulaErrorCode errorType;
  final int position;

  FormulaErrorInTerms({required this.position, required this.errorType});
}

enum FormulaErrorCode {
  undefinedTerm(1),
  missingOpeningBracket(2),
  missingClosingBracket(3),
  missingLeftOperand(4),
  missingRightOperand(5),
  emptyBrackets(6),
  ;

  final int code;
  const FormulaErrorCode(this.code);
}
