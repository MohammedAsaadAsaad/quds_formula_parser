
# Quds Formula Parser

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Pub Version](https://img.shields.io/pub/v/quds_formula_parser.svg)
 

Quds Formula Parser is a powerful Dart package designed to parse, evaluate, and manipulate mathematical formulas in various forms. It supports diverse data types, including numbers, dates, and custom objects, offering a flexible solution for formula-based calculations.

  

## Features

  

-  **Formula Parsing**: Convert mathematical expressions from infix to postfix notation.

-  **Customizable Terms**: Define custom functions, operators, and variables.

-  **Data Types Support**: Handle complex data types such as numbers, dates, durations, and logical expressions.

-  **Extensible**: Easily extend the library to support custom terms, types, and functions.

  
## Supported Types
| **Category**          | **Type**               | **Description**                                                                                      |
|-----------------------|------------------------|------------------------------------------------------------------------------------------------------|
| **Numbers**           | Real Numbers           | Represented by `num` and other numerical utilities.                                                |
|                       | Complex Numbers        | Handling of complex numbers through the `ComplexNumber` class.                                     |
|                       | Boolean/Logic          | Boolean values are managed through `BooleanWrapper` and related logic types.                       |
| **Date and Time**     | Date                   | Managed by the `Date` class for handling date-related functionalities.                              |
|                       | Time                   | Handled by the `Time` class for time manipulations.                                                |
|                       | Duration               | Represented by the `QudsDuration` class for handling time spans.                                   |
|                       | DateTime               | `QudsDateTime` class adds specific custom handling for datetime operations.                        |
| **Math and Geometry** | 2D Point               | Handled by the `Point2D` class, which represents a point in a two-dimensional space.               |
|                       | 3D Point               | Handled by the `Point3D` class for three-dimensional geometry.                                      |
| **Strings**           | Strings                | Managed by `StringWrapper` and `Strings` classes for string manipulation.                          |
| **Iterables**         | Iterable               | Represents a collection of elements that can be iterated over, such as lists or sets.             |
| **Science**           | Atom                   | Scientific data types related to chemistry and atomic structure represented by the `Atom` class.   |


----------
### **Operators (Defined in the Package)**:
| **Category**          | **Operator**         | **Description**                                            |
|-----------------------|----------------------|------------------------------------------------------------|
| **Arithmetic**        | `+`                  | Addition operator for numerical values or strings.        |
|                       | `-`                  | Subtraction operator for numerical values.                |
|                       | `*`                  | Multiplication operator for numerical values.             |
|                       | `/`                  | Division operator for numerical values.                   |
|                       | `%`                  | Modulus operator to find the remainder of division.      |
|                       | `^`                  | Exponentiation operator for raising numbers to a power.  |
| **Comparison**        | `==`                 | Equality operator to compare two values.                  |
|                       | `!=`                 | Inequality operator to check if two values are different. |
|                       | `>`                  | Greater than operator for numerical comparison.           |
|                       | `<`                  | Less than operator for numerical comparison.              |
|                       | `>=`                 | Greater than or equal to operator for numerical comparison.|
|                       | `<=`                 | Less than or equal to operator for numerical comparison.  |

----------

### **Functions (Defined in the Package)**:
| **Category**              | **Supported Functions**                                                                                                                      |
|---------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------|
| **Mathematical Functions** | `Abs`, `Int`, `Floor`, `Ceiling`, `SqRt`, `Square`, `Exp`, `Pow`, `Mod`, `GCD`, `LCM`, `Factorial`, `Fibonacci`, `IsPrime`, `IsEven`, `IsOdd`, `Clamp` |
| **Trigonometric Functions**| `Sin`, `Cos`, `Tan`, `Cot`, `Sec`, `Csc`, `ASin`, `ACos`, `ATan`, `ATan2`                                                                      |
| **Logical Functions**      | `If`, `And`, `Or`, `Not`, `XOR`, `IfError`, `RandomBool`, `AllTrue`, `AnyTrue`, `AllFalse`, `AnyFalse`                                         |
| **String Functions**       | `Len`, `Lower`, `Upper`, `Trim`, `TrimLeft`, `TrimRight`, `Replace`, `Contains`, `StartsWith`, `EndsWith`, `Concat`, `ToStr`                   |
| **Date & Time Functions**  | `Date`, `Year`, `Month`, `Day`, `WeekDay`, `Days`, `Now`, `Today`, `Hour`, `Minute`, `Second`                                                  |
| **Geometry Functions**     | `Point`, `Point.X`, `Point.Y`, `Point.Z`, `Distance`, `Hypotenuse`                                                                             |
| **Statistical Functions**  | `Avg`, `Product`, `Count`, `Max`, `Min`, `Median`, `Sum`, `Variance`, `StDev`, `Mode`, `Permutations`, `Combinations`                          |
| **Iterable Functions**     | `List`, `Reverse`                                                                                                                             |
| **Set Operations**         | `Set`, `Union`, `Intersect`, `Difference`                                                                                                     |
| **Atom Functions**         | `Atom`, `Atom.Name`, `Atom.Symbol`, `Atom.Number`, `Atom.Weight`, `Atom.BoilingPoint`, `Atom.MeltingPoint`, `Atom.Density`, `Atom.IonizationEnergy`, `Atom.Row`, `Atom.Column`, `Atom.EarthCrust`, `Atom.DiscoveryYear`, `Atom.GroupNumber` |
| **Core Functions**         | `Type`, `ValueType`, `IsNumber`, `IsReal`, `IsComplex`, `IsPoint`, `IsPoint2D`, `IsPoint3D`, `IsDate`, `IsTime`, `IsDateTime`, `IsDuration`, `IsBool`, `IsFraction`, `IsAtom`, `IsText` |


## Installation

Add the following to your `pubspec.yaml` file:

  

```yaml

dependencies:

quds_formula_parser: ^1.0.0

```

  

Then, run:

  

```bash

flutter  pub  get

```

  

## Usage

  

### Basic Usage

  

Here's an example of parsing and evaluating a simple formula:

  

```dart
import 'package:quds_formula_parser/quds_formula_parser.dart';

dynamic _parseFormulaAndEvaluate(String str) {
  FormulaParser parser = FormulaParser();

  var formula = parser.parse(str);

  var supporter = FormulaInfixToPostfixConvertor(formula: formula);

  var result = supporter.evaluate();

  if (result is ValueWrapper) return result.value;

  return result;
}

void main() {
  _evaluateSimpleFormulas();
}

```

  

### Supporting and setting variable values

  

You can also define custom variable and use it with custom value in your formulas:

  

```dart
import 'package:quds_formula_parser/quds_formula_parser.dart';

void _evaluatingWithVariables() {
  var provider = FormulaProvider.defaultInstance;

  FormulaParser parser = FormulaParser(provider: provider);

  provider.insertVariable(Variable(symbol: 'x', value: 0));

  String formulaStr = 'power(x,2)';

  var formula = parser.parse(formulaStr);

  var supporter = FormulaInfixToPostfixConvertor(formula: formula);

  Stopwatch stopwatch = Stopwatch();

  stopwatch.start();

  int times = 1000000;

  for (int i = 0; i < times; i++) {
    provider.setVariableValue('x', i);

    supporter.evaluate();
  }

  stopwatch.stop();

  print(
      '$formulaStr evaluating times($times) took ${stopwatch.elapsedMilliseconds} ms');
}

void main() {
  _evaluatingWithVariables();
}
```


### Defining custom function with using it

  

You can also define custom function and use it in your formulas:

  

```dart
import 'package:quds_formula_parser/quds_formula_parser.dart';

void _parseAndEvaluateWithCustomProvider() {
// Prepare the terms provider

  FormulaProvider provider = FormulaProvider();

  provider.identifiers.addAll([
    BracketIdentifier(),
    NamedValuesIdentifier(provider: provider),
    FunctionIdentifier(functions: [_CustomFunction()])
  ]);

// Prepare the parser

  var parser = FormulaParser(provider: provider);

  provider.insertVariable(Variable(symbol: 'x', value: 0));

  var formula = parser.parse('randomize(x)');

  var supporter = FormulaInfixToPostfixConvertor(formula: formula);

  for (int i = 0; i < 10; i++) {
    provider.setVariableValue('x', i);

    print(supporter.evaluate());
  }
}

void main() {
  _parseAndEvaluateWithCustomProvider();
}
```

  

## Example

  
See the [example](example/quds_formula_parser_example.dart) directory for a full example on how to use the package.

  

## Contributions

Contributions are welcome! Feel free to submit pull requests or open issues on our GitHub page.

  

## License

This package is licensed under the MIT License. See the LICENSE file for more information.