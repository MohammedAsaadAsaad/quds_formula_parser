import 'package:quds_formula_parser/quds_formula_parser.dart';

class FormulaSimplifier extends FormulaTermsSupporter {
  FormulaSimplifier({required super.formula});

  @override
  FormulaSupporterResult organize() {
    List<FormulaTerm> terms = [];
    _simplify(formula.terms);
    _reform(formula.terms);
    return FormulaSupporterResult(terms: terms);
  }

  void _simplify(List<FormulaTerm> terms) {
    bool simplified;
    var simplifyingFunctions = [
      _removeRedundantBrackets,
      _createMonomials,
      _combineLikeMonomialsAddition,
      _combineLikeMonomialsMultiplication,
      _performMonomialWithRealNumberMultiplications,
      _performMonomialWithRealNumberAddition,
      _performRealNumberMultiplications, _performMonomialPower,
      // _distributeMultiplicationTest,
      // _distributeExponentiationTest,
      // _combinePowersTest,
    ];

    do {
      simplified = false;

      for (var f in simplifyingFunctions) {
        if (f(terms)) {
          simplified = true;
          continue;
        }
      }
    } while (simplified);
  }

  void _reform(List<FormulaTerm> terms) {
    for (int i = 0; i < terms.length; i++) {
      var curr = terms[i];
      if (curr is Monomial) {
        terms.removeAt(i);

        if (curr.coefficient.value == 0) {
          terms.insert(i, curr.coefficient);
          continue;
        }

        if (curr.exponent.value != 1) {
          terms.insert(i, curr.exponent);
          terms.insert(i, PowerOperator());
        }

        terms.insert(i, curr.namedValue);

        if (curr.coefficient.value != 1) {
          terms.insert(i, MultiplyOperator());
          terms.insert(i, curr.coefficient);
        }
      }
    }
  }

  bool _removeRedundantBrackets(List<FormulaTerm> terms) {
    for (int i = 0; i < terms.length; i++) {
      var term = terms[i];

      if (term.isOpeningBracket) {
        if (i > 0 && terms[i - 1].isFunction) {
          continue;
        }

        int closingBracketIndex = _findClosingBracket(i);

        if (closingBracketIndex == -1) {
          continue;
        }

        if (closingBracketIndex > i + 1) {
          var subExpression = terms.sublist(i + 1, closingBracketIndex);
          bool containsOperator = subExpression.any((t) => t.isOperator);

          if (!containsOperator && subExpression.length == 1) {
            terms.removeAt(closingBracketIndex);
            terms.removeAt(i);
            i -= 2;
            return true;
          }
        }
      }
    }
    return false;
  }

  int _findClosingBracket(int openingBracketIndex) {
    int depth = 0;
    for (int i = openingBracketIndex; i < formula.terms.length; i++) {
      var term = formula.terms[i];
      if (term.isOpeningBracket) {
        depth++;
      } else if (term.isClosingBracket) {
        depth--;
        if (depth == 0) {
          return i;
        }
      }
    }
    return -1;
  }

  bool _areTypesLike(
      List<Type> types, List<FormulaTerm> terms, int startIndex) {
    if (terms.length < startIndex + types.length) {
      return false;
    }

    var subList = terms.sublist(startIndex, startIndex + types.length);

    for (int i = 0; i < subList.length; i++) {
      if (subList[i].runtimeType != types[i]) {
        return false;
      }
    }
    return true;
  }

  bool _consideredMonomial(
      List<Type> types, List<FormulaTerm> terms, int startIndex) {
    bool isHigherPrecedence(FormulaTerm term) {
      if (term is PowerOperator) return true;
      return false;
    }

    if (startIndex > 0) {
      var prevTerm = terms[startIndex - 1];
      if (isHigherPrecedence(prevTerm)) return false;
    }
    if (startIndex + terms.length + 1 < terms.length) {
      var nextTerm = terms[startIndex + terms.length + 1];
      if (isHigherPrecedence(nextTerm)) return false;
    }

    return _areTypesLike(types, terms, startIndex);
  }

  bool _areCombinableMonomialsAddition(
      List<Type> types, List<FormulaTerm> terms, int startIndex) {
    bool isHigherPrecedence(FormulaTerm term) {
      if (term is PowerOperator) return true;
      if (term is MultiplyOperator) return true;
      if (term is DivisionOperator) return true;
      return false;
    }

    if (startIndex > 0) {
      var prevTerm = terms[startIndex - 1];
      if (isHigherPrecedence(prevTerm)) return false;
    }
    if (startIndex + terms.length + 1 < terms.length) {
      var nextTerm = terms[startIndex + terms.length + 1];
      if (isHigherPrecedence(nextTerm)) return false;
    }

    return _areTypesLike(types, terms, startIndex);
  }

  bool _areCombinableMonomialsMultiplication(
      List<Type> types, List<FormulaTerm> terms, int startIndex) {
    bool isHigherPrecedence(FormulaTerm term) {
      if (term is PowerOperator) return true;
      return false;
    }

    if (startIndex > 0) {
      var prevTerm = terms[startIndex - 1];
      if (isHigherPrecedence(prevTerm)) return false;
    }
    if (startIndex + terms.length + 1 < terms.length) {
      var nextTerm = terms[startIndex + terms.length + 1];
      if (isHigherPrecedence(nextTerm)) return false;
    }

    return _areTypesLike(types, terms, startIndex);
  }

  bool _performMonomialWithRealNumberMultiplications(List<FormulaTerm> terms) {
    bool simplified = false;
    for (int i = 0; i < terms.length; i++) {
      if (_areCombinableNumbersMultiplication(
          [Monomial, MultiplyOperator, RealNumberWrapper], terms, i)) {
        var m = terms[i] as Monomial;
        var number = terms[i + 2] as RealNumberWrapper;
        terms.removeRange(i, i + 3);
        terms.insert(
            i,
            Monomial(
                coefficient: m.coefficient * number,
                namedValue: m.namedValue,
                exponent: m.exponent));
        simplified = true;
      } else if (_areCombinableNumbersMultiplication(
          [RealNumberWrapper, MultiplyOperator, Monomial], terms, i)) {
        var m = terms[i + 2] as Monomial;
        var number = terms[i] as RealNumberWrapper;
        terms.removeRange(i, i + 3);
        terms.insert(
            i,
            Monomial(
                coefficient: m.coefficient * number,
                namedValue: m.namedValue,
                exponent: m.exponent));
        simplified = true;
      }
    }
    return simplified;
  }

  bool _performMonomialWithRealNumberAddition(List<FormulaTerm> terms) {
    bool simplified = false;
    for (int i = 0; i < terms.length; i++) {
      if (_areCombinableNumbersAddition(
              [RealNumberWrapper, AddOperator, RealNumberWrapper], terms, i) ||
          _areCombinableNumbersAddition(
              [RealNumberWrapper, SubtractOperator, RealNumberWrapper],
              terms,
              i)) {
        var first = terms[i] as RealNumberWrapper;
        var second = terms[i + 2] as RealNumberWrapper;
        var operator = terms[i + 1];
        terms.removeRange(i, i + 3);
        terms.insert(
            i, operator is AddOperator ? first + second : first - second);
        simplified = true;
      }
    }
    return simplified;
  }

  bool _areCombinableNumbersMultiplication(
      List<Type> types, List<FormulaTerm> terms, int startIndex) {
    bool isHigherPrecedence(FormulaTerm term) {
      if (term is PowerOperator) {
        return true;
      }
      return false;
    }

    if (startIndex > 0) {
      var prevTerm = terms[startIndex - 1];
      if (isHigherPrecedence(prevTerm)) {
        return false;
      }
    }
    if (startIndex + terms.length + 1 < terms.length) {
      var nextTerm = terms[startIndex + terms.length + 1];
      if (isHigherPrecedence(nextTerm)) {
        return false;
      }
    }

    bool result = _areTypesLike(types, terms, startIndex);
    if (result) {
      return true;
    } else {
      return false;
    }
  }

  bool _areCombinableNumbersAddition(
      List<Type> types, List<FormulaTerm> terms, int startIndex) {
    bool isHigherPrecedence(FormulaTerm term) {
      if (term is PowerOperator) return true;
      if (term is MultiplyOperator) return true;
      if (term is DivisionOperator) return true;
      return false;
    }

    if (startIndex > 0) {
      var prevTerm = terms[startIndex - 1];
      if (isHigherPrecedence(prevTerm)) {
        return false;
      }
    }
    if (startIndex + terms.length + 1 < terms.length) {
      var nextTerm = terms[startIndex + terms.length + 1];
      if (isHigherPrecedence(nextTerm)) {
        return false;
      }
    }

    bool result = _areTypesLike(types, terms, startIndex);
    if (result) {
      return true;
    } else {
      return false;
    }
  }

  bool _performRealNumberMultiplications(List<FormulaTerm> terms) {
    bool simplified = false;
    for (int i = 0; i < terms.length; i++) {
      if (_areCombinableNumbersMultiplication(
          [RealNumberWrapper, MultiplyOperator, RealNumberWrapper], terms, i)) {
        var first = terms[i] as RealNumberWrapper;
        var second = terms[i + 2] as RealNumberWrapper;
        terms.removeRange(i, i + 3);
        terms.insert(i, first * second);
        simplified = true;
      }
    }
    return simplified;
  }

  bool _combineLikeMonomialsAddition(List<FormulaTerm> terms) {
    bool simplified = false;
    for (int i = 0; i < terms.length; i++) {
      if (_areCombinableMonomialsAddition(// 0.2*x^2 + 5*x^2 => 5.2*x^2
              [Monomial, AddOperator, Monomial], terms, i) ||
          _areCombinableMonomialsAddition(// 0.2*x^2 - 5*x^2 => -4.8*x^2
              [Monomial, SubtractOperator, Monomial], terms, i)) {
        var first = terms[i] as Monomial;
        var operator = terms[i + 1];
        var second = terms[i + 2] as Monomial;
        if (first.likes(second)) {
          terms.removeRange(i, i + 3);
          terms.insert(
              i,
              Monomial(
                  coefficient: operator is AddOperator
                      ? first.coefficient + second.coefficient
                      : first.coefficient - second.coefficient,
                  namedValue: first.namedValue,
                  exponent: first.exponent));
          simplified = true;
        }
      }
    }
    return simplified;
  }

  bool _performMonomialPower(List<FormulaTerm> terms) {
    for (int i = 0; i < terms.length; i++) {
      if (_areTypesLike(
          [Monomial, PowerOperator, RealNumberWrapper], terms, i)) {
        var monomial = terms[i] as Monomial;
        var exponent = terms[i + 2] as RealNumberWrapper;
        terms.removeRange(i, i + 3);
        terms.insert(
            i,
            Monomial(
                coefficient: monomial.coefficient.pow(exponent.value),
                namedValue: monomial.namedValue,
                exponent: exponent));
        return true;
      }
    }
    return false;
  }

  bool _combineLikeMonomialsMultiplication(List<FormulaTerm> terms) {
    bool simplified = false;
    for (int i = 0; i < terms.length; i++) {
      if (_areCombinableMonomialsMultiplication(
              // 2 * x ^ 2 * 1.5 * x ^ 3 =>3 * x ^ 5
              [Monomial, MultiplyOperator, Monomial],
              terms,
              i) ||
          _areCombinableMonomialsMultiplication(
              // 3 * x ^ 2 / 1.5 * x ^ 3 =>2 * x ^ -1
              [Monomial, DivisionOperator, Monomial],
              terms,
              i)) {
        var first = terms[i] as Monomial;
        var operator = terms[i + 1];
        var second = terms[i + 2] as Monomial;
        terms.removeRange(i, i + 3);
        terms.insert(
            i,
            Monomial(
                coefficient: operator is MultiplyOperator
                    ? first.coefficient * second.coefficient
                    : first.coefficient / second.coefficient,
                namedValue: first.namedValue,
                exponent: operator is MultiplyOperator
                    ? first.exponent + second.exponent
                    : first.exponent - second.exponent));
        simplified = true;
      }
    }
    return simplified;
  }

  bool _createMonomials(List<FormulaTerm> terms) {
    bool simplified = false;

    for (int i = 0; i < terms.length; i++) {
      if (_consideredMonomial([
        RealNumberWrapper,
        MultiplyOperator,
        NamedValue,
        PowerOperator,
        RealNumberWrapper
      ], terms, i)) {
        // 5 * x ^ 2
        var coef = terms[i] as RealNumberWrapper;
        var namedValue = terms[i + 2] as NamedValue;
        var exponent = terms[i + 4] as RealNumberWrapper;
        terms.removeRange(i, i + 5);
        terms.insert(
            i,
            Monomial(
                coefficient: coef, namedValue: namedValue, exponent: exponent));
        simplified = true;
      } else if (_consideredMonomial([
        NamedValue,
        PowerOperator,
        RealNumberWrapper,
        MultiplyOperator,
        RealNumberWrapper,
      ], terms, i)) {
        // x ^ 2 * -9
        var coef = terms[i + 4] as RealNumberWrapper;
        var namedValue = terms[i] as NamedValue;
        var exponent = terms[i + 2] as RealNumberWrapper;
        terms.removeRange(i, i + 5);
        terms.insert(
            i,
            Monomial(
                coefficient: coef, namedValue: namedValue, exponent: exponent));
        simplified = true;
      } else if (_consideredMonomial(
          [NamedValue, PowerOperator, RealNumberWrapper], terms, i)) {
        // x ^ 2
        var namedValue = terms[i] as NamedValue;
        var exponent = terms[i + 2] as RealNumberWrapper;
        terms.removeRange(i, i + 3);
        terms.insert(
            i,
            Monomial(
                coefficient: RealNumberWrapper.one,
                namedValue: namedValue,
                exponent: exponent));
        simplified = true;
      } else if (_consideredMonomial(
          [RealNumberWrapper, MultiplyOperator, NamedValue], terms, i)) {
        // 5 * x
        var coef = terms[i] as RealNumberWrapper;
        var namedValue = terms[i + 2] as NamedValue;
        terms.removeRange(i, i + 3);
        terms.insert(
            i,
            Monomial(
                coefficient: coef,
                namedValue: namedValue,
                exponent: RealNumberWrapper.one));
        simplified = true;
      } else if (_consideredMonomial([
        NamedValue,
        PowerOperator,
        RealNumberWrapper,
      ], terms, i)) {
        // x * -9
        var exponent = terms[i + 2] as RealNumberWrapper;
        var namedValue = terms[i] as NamedValue;
        terms.removeRange(i, i + 3);
        terms.insert(
            i,
            Monomial(
                coefficient: RealNumberWrapper.one,
                namedValue: namedValue,
                exponent: exponent));
        simplified = true;
      } else if (_consideredMonomial([
        NamedValue,
        MultiplyOperator,
        RealNumberWrapper,
      ], terms, i)) {
        // x * -9
        var coef = terms[i + 2] as RealNumberWrapper;
        var namedValue = terms[i] as NamedValue;
        terms.removeRange(i, i + 3);
        terms.insert(
            i,
            Monomial(
                coefficient: coef,
                namedValue: namedValue,
                exponent: RealNumberWrapper.one));
        simplified = true;
      } else if (_consideredMonomial([NamedValue], terms, i)) {
        // x
        var namedValue = terms[i] as NamedValue;
        terms.removeAt(i);
        terms.insert(
            i,
            Monomial(
                coefficient: RealNumberWrapper.one,
                namedValue: namedValue,
                exponent: RealNumberWrapper.one));
        simplified = true;
      }
    }
    return simplified;
  }

  // bool _distributeMultiplicationTest(List<FormulaTerm> terms) {
  //   for (int i = 0; i < terms.length; i++) {
  //     if (_areTypesLike(
  //         [MultiplyOperator, NamedValue, OpeningBracket], terms, i)) {
  //       int closingBracketIndex = _findClosingBracket(i + 1);
  //       var innerTerms = terms.sublist(i + 2, closingBracketIndex);
  //       // Distribute the NamedValue over inner terms
  //       var distributedTerms = innerTerms.map((term) {
  //         return Monomial(
  //           coefficient: RealNumberWrapper.one,
  //           namedValue: (terms[i - 1] as NamedValue),
  //           exponent: RealNumberWrapper.one,
  //         );
  //       }).toList();
  //       // Replace with distributed terms
  //       terms.replaceRange(i - 1, closingBracketIndex + 1, distributedTerms);
  //       return true;
  //     }
  //   }
  //   return false;
  // }

  // bool _distributeExponentiationTest(List<FormulaTerm> terms) {
  //   for (int i = 0; i < terms.length; i++) {
  //     if (_areTypesLike([
  //       RealNumberWrapper,
  //       MultiplyOperator,
  //       NamedValue,
  //       PowerOperator,
  //       RealNumberWrapper
  //     ], terms, i)) {
  //       // Exponentiation distribution: (2 * x)^2 becomes 4 * x^2
  //       var baseNumber = terms[i] as RealNumberWrapper;
  //       var exponent = terms[i + 4] as RealNumberWrapper;
  //       var newCoefficient = baseNumber.pow(exponent.value);
  //       terms.removeRange(i, i + 5);
  //       terms.insert(
  //           i,
  //           Monomial(
  //             coefficient: newCoefficient,
  //             namedValue: terms[i + 2] as NamedValue,
  //             exponent: exponent,
  //           ));
  //       return true;
  //     }
  //   }
  //   return false;
  // }

  // bool _combinePowersTest(List<FormulaTerm> terms) {
  //   for (int i = 0; i < terms.length; i++) {
  //     if (_areCombinableMonomialsMultiplication(
  //         [Monomial, MultiplyOperator, Monomial], terms, i)) {
  //       var first = terms[i] as Monomial;
  //       var second = terms[i + 2] as Monomial;

  //       if (first.namedValue.symbol == second.namedValue.symbol) {
  //         var newExponent = first.exponent.value + second.exponent.value;
  //         terms.removeRange(i, i + 3);
  //         terms.insert(
  //             i,
  //             Monomial(
  //                 coefficient: first.coefficient * second.coefficient,
  //                 namedValue: first.namedValue,
  //                 exponent: RealNumberWrapper(newExponent)));
  //         return true;
  //       }
  //     }
  //   }
  //   return false;
  // }

  @override
  evaluate() => NullValue();
}
