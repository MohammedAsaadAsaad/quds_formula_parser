import 'dart:collection';
import 'package:quds_formula_parser/quds_formula_parser.dart';

/// A class that converts infix formula terms to postfix notation.
///
/// This class extends [FormulaTermsSupporter] and organizes formula terms
/// into postfix order for easier evaluation.
class FormulaInfixToPostfixConvertor extends FormulaTermsSupporter {
  FormulaInfixToPostfixConvertor(
      {required super.formula, this.autoCompleteMissingTerms = true});
  final bool autoCompleteMissingTerms;

  /// The resulting output in postfix order.
  List<FormulaTerm> output = [];

  /// Cached bracket pairs for O(1) lookup: maps left bracket index to right bracket index
  late final Map<int, int> _bracketPairs;
  bool _bracketsCached = false;

  /// Organizes the formula terms into postfix notation.
  ///
  /// Parses through the terms in the infix formula and applies the Shunting-yard algorithm
  /// to convert the terms into postfix notation, handling operators, functions, and parentheses.
  ///
  /// Returns a [FormulaSupporterResult] containing the organized terms and any messages
  /// that may have occurred during the process.
  @override
  FormulaSupporterResult organize() {
    if (autoCompleteMissingTerms) {
      FormulaTermsCompleter(formula: formula);
    }

    if (!formula.hasParsingError) {
      // Pre-compute bracket pairs for O(1) lookup during algorithm
      _cacheBracketPairs();

      output.clear();
      Queue<FormulaTerm> operators = Queue();
      Queue<int> argumentCount = Queue();

      int termIndex = -1;
      for (var t in formula.terms) {
        termIndex++;
        if (t.isFunction || t.isNamedValue) {
          if (t.isFunction) {
            operators.addFirst(t);
            int argsCount = 1;
            if (formula.terms.length > termIndex + 2) {
              if (formula.terms[termIndex + 1].isLeftBracket &&
                  formula.terms[termIndex + 2].isRightBracket) {
                argsCount = 0;
              }
            }
            argumentCount.addFirst(argsCount);
          } else {
            output.add(t);
          }
        } else if (t.isValue) {
          output.add(t);
        } else if (t.isComma) {
          // Handle the comma between function arguments
          while (operators.isNotEmpty && !operators.first.isLeftBracket) {
            output.add(operators.removeFirst());
          }
          var argsCount = argumentCount.removeFirst();
          argumentCount.addFirst(
              argsCount + 1); // Increment argument count for current function
        } else if (t.isOperator) {
          while (operators.isNotEmpty && operators.first.isOperator) {
            Operator topOp = operators.first as Operator;
            if ((topOp.hasHigherPrecedence(t as Operator) ||
                    topOp.hasEqualPrecedence(t)) &&
                !t.isRightAssociative) {
              output.add(operators.removeFirst());
            } else {
              break;
            }
          }
          operators.addFirst(t);
        } else if (t.isLeftBracket) {
          operators.addFirst(t);
        } else if (t.isRightBracket) {
          while (operators.isNotEmpty && !operators.first.isLeftBracket) {
            output.add(operators.removeFirst());
          }

          operators.removeFirst(); // Remove the left parenthesis

          if (operators.isNotEmpty && operators.first.isFunction) {
            output.add(operators.removeFirst());
            output.add(RealNumberWrapper(argumentCount
                .removeFirst())); // Add argument count for the function
          }
        }
      }

      while (operators.isNotEmpty) {
        output.add(operators.removeFirst());
      }
    }

    return FormulaSupporterResult(terms: output);
  }

  /// Pre-computes bracket pairs for O(1) lookup during evaluation.
  /// Maps left bracket indices to their corresponding right bracket indices.
  void _cacheBracketPairs() {
    if (_bracketsCached) return;
    _bracketPairs = {};

    List<int> leftStack = [];
    for (int i = 0; i < formula.terms.length; i++) {
      if (formula.terms[i].isLeftBracket) {
        leftStack.add(i);
      } else if (formula.terms[i].isRightBracket) {
        if (leftStack.isNotEmpty) {
          int leftIdx = leftStack.removeLast();
          _bracketPairs[leftIdx] = i;
        }
      }
    }
    _bracketsCached = true;
  }

  /// Evaluates the postfix expression and calculates the result.
  ///
  /// Uses a stack to evaluate the postfix notation of the formula, applying operators and
  /// functions as necessary. Returns the final result of the evaluation.
  /// Stack capacity is pre-allocated based on formula complexity to minimize resizing.
  @override
  ValueWrapper evaluate() {
    // Calculate expected stack depth based on formula complexity
    _calculateExpectedStackDepth();
    List<ValueWrapper> stack = List<ValueWrapper>.empty(growable: true);
    stack.length = 0; // Ensure empty but with allocated capacity

    List<FormulaTerm> terms = output;

    int termsIndex = -1;
    bool functionFound = false;
    for (var t in terms) {
      termsIndex++;
      if (functionFound) {
        functionFound = false;
        continue;
      }

      if (t.isValue || t.isNamedValue) {
        var value = t.toFormulaValueType();
        stack.add(value);
      } else if (t.isOperator) {
        var b = toFormulaValue(stack.removeLast());
        var a = toFormulaValue(stack.removeLast());
        ValueWrapper result;
        result = toFormulaValue((t as Operator).calculate(a, b));

        stack.add(result);
      } else if (t.isFunction) {
        if (output.length <= termsIndex + 1) return NAValue();

        int argCount =
            (output[termsIndex + 1] as RealNumberWrapper).value.toInt();

        List<ValueWrapper> args = [];
        for (int i = 0; i < argCount; i++) {
          args.add(stack.removeLast());
        }

        var fun = t as FormulaFunction;
        var params = args.reversed.toList();

        var result = fun.checkParameters(params)
            ? fun.calculateAndManipulate(params)
            : NAValue();

        stack.add(toFormulaValue(result));
        functionFound = true;
      }
    }

    return stack.isNotEmpty ? stack.last : NAValue();
  }

  /// Calculates expected stack depth based on output terms.
  /// Used for pre-allocating stack capacity to reduce resizing during evaluation.
  int _calculateExpectedStackDepth() {
    int depth = 0;
    int maxDepth = 0;
    for (var t in output) {
      if (t.isValue || t.isNamedValue) {
        depth++;
      } else if (t.isOperator) {
        depth--; // Operator consumes 2, produces 1
      } else if (t.isFunction) {
        // Function consumes multiple args and produces 1
        depth = (depth > 0) ? depth : 1;
      }
      maxDepth = (depth > maxDepth) ? depth : maxDepth;
    }
    return maxDepth + 10; // Add buffer
  }
}
