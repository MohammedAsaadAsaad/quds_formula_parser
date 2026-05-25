# Quds Formula Parser

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Pub Version](https://img.shields.io/pub/v/quds_formula_parser.svg)

Quds Formula Parser is a comprehensive Dart package for parsing, evaluating, and manipulating mathematical, logical, and textual formulas. It enables developers to create dynamic, formula-driven applications with support for a wide range of data types, custom functions, and operators. Whether you're building a spreadsheet engine, a scientific calculator, or a business rules evaluator, this package provides the robust foundation you need.

## Key Features

- **Powerful Formula Parsing**: Parse mathematical expressions and convert them from infix to postfix notation with full error reporting
- **Rich Data Type Support**: Work seamlessly with numbers, complex numbers, dates, times, durations, points in 2D/3D space, strings, atoms, and iterables
- **Comprehensive Built-in Functions**: Access over 100 pre-built mathematical, trigonometric, logical, statistical, and utility functions
- **Custom Functions & Operators**: Define your own functions and operators tailored to your specific needs
- **Formula Simplification**: Automatically simplify formulas for optimization and readability
- **Variables & Context**: Support for dynamic variables with real-time value changes
- **Error Handling**: Detailed parsing error detection and reporting with position information
- **High Performance**: Optimized parsing and evaluation for handling millions of operations
- **Type Safety**: Robust type checking and automatic type conversions where applicable
- **Extensible Architecture**: Build custom identifiers, functions, and operators by extending core classes

## Supported Data Types

| **Category** | **Type** | **Description** |
|---|---|---|
| **Numbers** | Real Numbers | Integers and floating-point numbers using `num` type |
| | Complex Numbers | Complex number operations via `ComplexNumber` class (e.g., `5 + 2i`) |
| | Boolean/Logic | Boolean values through `BooleanWrapper` for logical operations |
| **Date & Time** | Date | Handle dates with the `Date` class (format: `#YYYY-MM-DD#`) |
| | Time | Time operations via `Time` class (format: `#HH:MM:SS#`) |
| | Duration | Time spans represented by `QudsDuration` class |
| | DateTime | Combined date and time operations through `QudsDateTime` |
| **Geometry** | Point 2D | Two-dimensional points via `Point2D` class (e.g., `{5, -1}`) |
| | Point 3D | Three-dimensional points via `Point3D` class (e.g., `{5, -1, 2}`) |
| **Strings** | String | Text manipulation through `StringWrapper` and `Strings` classes |
| **Iterables** | List/Set | Collections of elements that can be iterated, filtered, and manipulated |
| **Science** | Atom | Chemical elements represented by `Atom` class with periodic table data |

## Operators Reference

### Arithmetic Operators
| Operator | Operation | Example |
|---|---|---|
| `+` | Addition / String concatenation | `5 + 3` → `8` or `"Hello " + "World"` → `"Hello World"` |
| `-` | Subtraction | `10 - 3` → `7` |
| `*` | Multiplication | `4 * 5` → `20` |
| `/` | Division | `20 / 4` → `5` |
| `%` | Modulus (remainder) | `17 % 5` → `2` |
| `^` | Exponentiation | `2 ^ 8` → `256` |

### Comparison Operators
| Operator | Operation | Example |
|---|---|---|
| `==` or `=` | Equality | `5 = 5` → `true` |
| `!=` or `<>` | Inequality | `5 != 3` → `true` |
| `>` | Greater than | `10 > 5` → `true` |
| `<` | Less than | `3 < 10` → `true` |
| `>=` | Greater than or equal | `5 >= 5` → `true` |
| `<=` | Less than or equal | `3 <= 10` → `true` |

### Logical Operators
| Operator | Operation | Example |
|---|---|---|
| `&` or `&&` | Logical AND | `true & false` → `false` |
| `\|` or `\|\|` | Logical OR | `true \| false` → `true` |
| `^` | Logical XOR | `true ^ false` → `true` |

## Built-in Functions

### Mathematical Functions
| Function | Description | Example |
|---|---|---|
| `Abs(x)` | Absolute value | `Abs(-5)` → `5` |
| `Int(x)` | Integer part | `Int(3.7)` → `3` |
| `Floor(x)` | Round down | `Floor(3.7)` → `3` |
| `Ceiling(x)` | Round up | `Ceiling(3.2)` → `4` |
| `SqRt(x)` | Square root | `SqRt(16)` → `4` |
| `Square(x)` | Square value | `Square(5)` → `25` |
| `Pow(x, y)` or `Power(x, y)` | Power | `Pow(2, 8)` → `256` |
| `Exp(x)` | e raised to power x | `Exp(1)` → `2.718...` |
| `Mod(x, y)` | Modulus | `Mod(17, 5)` → `2` |
| `GCD(x, y)` | Greatest common divisor | `GCD(48, 18)` → `6` |
| `LCM(x, y)` | Least common multiple | `LCM(12, 18)` → `36` |
| `Factorial(n)` | Factorial | `Factorial(5)` → `120` |
| `Fibonacci(n)` | Fibonacci number | `Fibonacci(7)` → `13` |
| `IsPrime(n)` | Check if prime | `IsPrime(17)` → `true` |
| `IsEven(n)` | Check if even | `IsEven(4)` → `true` |
| `IsOdd(n)` | Check if odd | `IsOdd(5)` → `true` |
| `Clamp(x, min, max)` | Constrain to range | `Clamp(50, 0, 100)` → `50` |

### Trigonometric Functions
| Function | Description | Example |
|---|---|---|
| `Sin(x)`, `Cos(x)`, `Tan(x)` | Sine, cosine, tangent (radians) | `Sin(π/2)` → `1` |
| `Cot(x)`, `Sec(x)`, `Csc(x)` | Cotangent, secant, cosecant | `Cot(π/4)` → `1` |
| `ASin(x)`, `ACos(x)`, `ATan(x)` | Inverse trig functions | `ASin(1)` → `π/2` |
| `ATan2(y, x)` | Two-argument arctangent | `ATan2(1, 1)` → `π/4` |

### String Functions
| Function | Description | Example |
|---|---|---|
| `Len(str)` | String length | `Len("Hello")` → `5` |
| `Lower(str)` | Convert to lowercase | `Lower("HELLO")` → `"hello"` |
| `Upper(str)` | Convert to uppercase | `Upper("hello")` → `"HELLO"` |
| `Trim(str)` | Remove leading/trailing spaces | `Trim("  hello  ")` → `"hello"` |
| `TrimLeft(str)` | Remove leading spaces | `TrimLeft("  hello")` → `"hello"` |
| `TrimRight(str)` | Remove trailing spaces | `TrimRight("hello  ")` → `"hello"` |
| `Replace(str, old, new)` | Replace substring | `Replace("hello", "l", "x")` → `"hexxo"` |
| `Contains(str, substr)` | Check if contains | `Contains("hello", "ell")` → `true` |
| `StartsWith(str, prefix)` | Check start | `StartsWith("hello", "he")` → `true` |
| `EndsWith(str, suffix)` | Check end | `EndsWith("hello", "lo")` → `true` |
| `Concat(str1, str2, ...)` | Concatenate strings | `Concat("Hello", " ", "World")` → `"Hello World"` |
| `ToStr(x)` | Convert to string | `ToStr(123)` → `"123"` |

### Date & Time Functions
| Function | Description | Example |
|---|---|---|
| `Date(year, month, day)` | Create date | `Date(2024, 8, 14)` → `#2024-08-14#` |
| `Today()` | Current date | `Today()` → `#2024-08-14#` |
| `Now()` | Current date and time | `Now()` → current timestamp |
| `Year(date)` | Extract year | `Year(#2024-08-14#)` → `2024` |
| `Month(date)` | Extract month | `Month(#2024-08-14#)` → `8` |
| `Day(date)` | Extract day | `Day(#2024-08-14#)` → `14` |
| `WeekDay(date)` | Day of week (0-6) | `WeekDay(#2024-08-14#)` → `3` |
| `Hour(time)` | Extract hours | `Hour(#13:45:30#)` → `13` |
| `Minute(time)` | Extract minutes | `Minute(#13:45:30#)` → `45` |
| `Second(time)` | Extract seconds | `Second(#13:45:30#)` → `30` |

### Logical Functions
| Function | Description | Example |
|---|---|---|
| `If(condition, true_val, false_val)` | Conditional | `If(5 > 3, "yes", "no")` → `"yes"` |
| `And(cond1, cond2, ...)` | Logical AND | `And(true, true)` → `true` |
| `Or(cond1, cond2, ...)` | Logical OR | `Or(true, false)` → `true` |
| `Not(condition)` | Logical NOT | `Not(false)` → `true` |
| `XOR(cond1, cond2)` | Exclusive OR | `XOR(true, false)` → `true` |
| `AllTrue(arr)` | All elements true | `AllTrue({true, true})` → `true` |
| `AnyTrue(arr)` | Any element true | `AnyTrue({true, false})` → `true` |
| `AllFalse(arr)` | All elements false | `AllFalse({false, false})` → `true` |
| `AnyFalse(arr)` | Any element false | `AnyFalse({true, false})` → `true` |
| `IfError(expr, fallback)` | Error handling | `IfError(1/0, 0)` → `0` |
| `RandomBool()` | Random boolean | `RandomBool()` → `true` or `false` |

### Statistical Functions
| Function | Description | Example |
|---|---|---|
| `Sum(x1, x2, ...)` | Sum of values | `Sum(1, 2, 3, 4)` → `10` |
| `Avg(x1, x2, ...)` | Average | `Avg(2, 4, 6)` → `4` |
| `Count(arr)` | Count elements | `Count({1, 2, 3})` → `3` |
| `Min(x1, x2, ...)` | Minimum value | `Min(5, 2, 8)` → `2` |
| `Max(x1, x2, ...)` | Maximum value | `Max(5, 2, 8)` → `8` |
| `Median(arr)` | Median value | `Median({1, 2, 3, 4, 5})` → `3` |
| `Product(x1, x2, ...)` | Product of values | `Product(2, 3, 4)` → `24` |
| `Variance(arr)` | Statistical variance | `Variance({1, 2, 3})` → `0.667` |
| `StDev(arr)` | Standard deviation | `StDev({1, 2, 3})` → `0.816` |
| `Mode(arr)` | Most frequent value | `Mode({1, 1, 2, 3})` → `1` |
| `Permutations(n, k)` | P(n, k) | `Permutations(5, 3)` → `60` |
| `Combinations(n, k)` | C(n, k) | `Combinations(5, 3)` → `10` |

### Geometry Functions
| Function | Description | Example |
|---|---|---|
| `Point(x, y)` or `Point(x, y, z)` | Create point | `Point(3, 4)` → `{3, 4}` |
| `Point.X(p)` | Extract X coordinate | `Point.X({5, 7})` → `5` |
| `Point.Y(p)` | Extract Y coordinate | `Point.Y({5, 7})` → `7` |
| `Point.Z(p)` | Extract Z coordinate | `Point.Z({5, 7, 2})` → `2` |
| `Distance(p1, p2)` | Distance between points | `Distance({0, 0}, {3, 4})` → `5` |
| `Hypotenuse(x, y)` | Pythagorean result | `Hypotenuse(3, 4)` → `5` |

### Set Operations
| Function | Description | Example |
|---|---|---|
| `Set(x1, x2, ...)` | Create set | `Set(1, 2, 3)` → `{1, 2, 3}` |
| `Union(set1, set2)` | Union of sets | `Union({1, 2}, {2, 3})` → `{1, 2, 3}` |
| `Intersect(set1, set2)` | Intersection | `Intersect({1, 2, 3}, {2, 3, 4})` → `{2, 3}` |
| `Difference(set1, set2)` | Set difference | `Difference({1, 2, 3}, {2, 3})` → `{1}` |

### List Functions
| Function | Description | Example |
|---|---|---|
| `List(x1, x2, ...)` | Create list | `List(1, 2, 3)` → `[1, 2, 3]` |
| `Reverse(list)` | Reverse list | `Reverse([1, 2, 3])` → `[3, 2, 1]` |
| `ElementAt(list, index)` | Get element at index | `ElementAt([10, 20, 30], 1)` → `20` |
| `IndexOf(list, item)` | Find index of item | `IndexOf(["a", "b", "c"], "b")` → `1` |

### Atom (Chemistry) Functions
| Function | Description | Example |
|---|---|---|
| `Atom(symbol)` | Create atom | `Atom('He')` → Helium atom |
| `Atom.Name(atom)` | Get element name | `Atom.Name('He)` → `"Helium"` |
| `Atom.Symbol(atom)` | Get element symbol | `Atom.Symbol('he)` → `"He"` |
| `Atom.Number(atom)` | Get atomic number | `Atom.Number('he)` → `2` |
| `Atom.Weight(atom)` | Get atomic weight | `Atom.Weight('he)` → `4.0026` |
| `Atom.BoilingPoint(atom)` | Get boiling point | `Atom.BoilingPoint('he)` → `4.216` |
| `Atom.MeltingPoint(atom)` | Get melting point | `Atom.MeltingPoint('he)` → `0.95` |
| `Atom.Density(atom)` | Get density | `Atom.Density('he)` → `0.1786` |
| `Atom.IonizationEnergy(atom)` | Get ionization energy | `Atom.IonizationEnergy('he)` → `24.587` |
| `Atom.Row(atom)` | Get periodic table row | `Atom.Row('he)` → `1` |
| `Atom.Column(atom)` | Get periodic table column | `Atom.Column('he)` → `18` |
| `Atom.EarthCrust(atom)` | Get earth crust abundance | `Atom.EarthCrust('he)` → `5.2e-7` |
| `Atom.DiscoveryYear(atom)` | Get discovery year | `Atom.DiscoveryYear('he)` → `1868` |
| `Atom.GroupNumber(atom)` | Get group number | `Atom.GroupNumber('he)` → `18` |

### Type Checking Functions
| Function | Description | Example |
|---|---|---|
| `Type(x)` | Get type name | `Type('He)` → `"Atom"` |
| `ValueType(x)` | Get value type | `ValueType(5)` → `"Number"` |
| `IsNumber(x)` | Check if number | `IsNumber(42)` → `true` |
| `IsReal(x)` | Check if real number | `IsReal(5)` → `true` |
| `IsComplex(x)` | Check if complex | `IsComplex(5+2i)` → `true` |
| `IsPoint(x)` | Check if point | `IsPoint({5, 2})` → `true` |
| `IsPoint2D(x)` | Check if 2D point | `IsPoint2D({5, 2})` → `true` |
| `IsPoint3D(x)` | Check if 3D point | `IsPoint3D({5, 2, 1})` → `true` |
| `IsDate(x)` | Check if date | `IsDate(#2024-08-14#)` → `true` |
| `IsTime(x)` | Check if time | `IsTime(#13:45:30#)` → `true` |
| `IsDateTime(x)` | Check if datetime | `IsDateTime(now())` → `true` |
| `IsDuration(x)` | Check if duration | `IsDuration(Days(5))` → `true` |
| `IsBool(x)` | Check if boolean | `IsBool(true)` → `true` |
| `IsFraction(x)` | Check if fraction | `IsFraction(1/2)` → `true` |
| `IsAtom(x)` | Check if atom | `IsAtom('He)` → `true` |
| `IsText(x)` | Check if text | `IsText("hello")` → `true` |

## Installation

Add the following to your `pubspec.yaml` file:

```yaml
dependencies:
  quds_formula_parser: ^0.0.10
```

Then run:

```bash
flutter pub get
```

Or for a pure Dart project:

```bash
dart pub get
```

## Usage

### Basic Parsing and Evaluation

The simplest way to use Quds Formula Parser is to parse and evaluate a formula string:

```dart
import 'package:quds_formula_parser/quds_formula_parser.dart';

void main() {
  FormulaParser parser = FormulaParser();
  
  // Parse and evaluate a simple formula
  var result = parser.parse('5 + 9 / 2').evaluate();
  print('Result: $result'); // Output: 9.5
  
  // Evaluate power operation
  result = parser.parse('6 ^ 3').evaluate();
  print('Result: $result'); // Output: 216
  
  // Boolean operations
  result = parser.parse('true & false').evaluate();
  print('Result: $result'); // Output: false
}
```

### Working with Variables

Variables allow you to create reusable formulas that can be evaluated with different values:

```dart
import 'package:quds_formula_parser/quds_formula_parser.dart';

void main() {
  FormulaParser parser = FormulaParser();
  
  // Define a variable
  parser.insertVariable(NamedValue(symbol: 'x', value: 0));
  
  // Parse the formula once
  parser.parse('power(x, 2) + 3 * x + 5');
  
  // Evaluate with different values
  for (int i = 0; i <= 5; i++) {
    parser.setVariableValue('x', i);
    var result = parser.evaluate();
    print('f($i) = $result');
  }
  // Output:
  // f(0) = 5
  // f(1) = 9
  // f(2) = 15
  // f(3) = 23
  // f(4) = 33
  // f(5) = 45
}
```

### Working with Different Data Types

Parse and evaluate formulas using various data types supported by the package:

```dart
import 'package:quds_formula_parser/quds_formula_parser.dart';

void main() {
  FormulaParser parser = FormulaParser();
  
  // Complex numbers
  var result = parser.parse('5 - (2+7i)').evaluate();
  print('Complex: $result'); // Output: 3.0 + -7.0i
  
  // Dates and time operations
  result = parser.parse('Day(#2024-08-14#)').evaluate();
  print('Day: $result'); // Output: 14
  
  result = parser.parse('WeekDay(#2024-08-14#)').evaluate();
  print('Day of week: $result'); // Output: 3 (Wednesday)
  
  // Points in 2D space
  result = parser.parse('Point.Y({5, -7})').evaluate();
  print('Y coordinate: $result'); // Output: -7
  
  // Distance calculation
  result = parser.parse('Distance({0, 0}, {3, 4})').evaluate();
  print('Distance: $result'); // Output: 5
  
  // String operations
  result = parser.parse('Len("Hello World")').evaluate();
  print('Length: $result'); // Output: 11
  
  // Atomic data (chemistry)
  result = parser.parse('Atom.Weight(\'He)').evaluate();
  print('Helium weight: $result'); // Output: 4.0026
}
```

### Conditional and Logical Operations

Build intelligent formulas with conditions and logical operations:

```dart
import 'package:quds_formula_parser/quds_formula_parser.dart';

void main() {
  FormulaParser parser = FormulaParser();
  
  // Simple condition
  var result = parser.parse('If(5 > 3, "Yes", "No")').evaluate();
  print('Result: $result'); // Output: Yes
  
  // Complex condition for leap year check
  result = parser.parse(
    'If(And(Year(Today())%4=0,Year(Today())%100<>0),"Leap year","Not leap year")'
  ).evaluate();
  print('Result: $result'); // Output: Leap year or Not leap year
  
  // Set operations
  result = parser.parse('Intersect(Set(2,5,9),Set(5,7,2))').evaluate();
  print('Intersection: $result'); // Output: [2, 5]
}
```

### Working with Lists and Collections

Create and manipulate lists within formulas:

```dart
import 'package:quds_formula_parser/quds_formula_parser.dart';

void main() {
  FormulaParser parser = FormulaParser();
  
  // Create a list of days
  parser.parse(
    'SetVariable("days",List("Saturday","Sunday","Monday","Tuesday","Wednesday","Thursday","Friday"))'
  ).evaluate();
  
  // Get current day of week
  parser.parse('ElementAt(days,WeekDay(Today()))');
  var result = parser.evaluate();
  print('Today is: $result');
  
  // Find index of a specific day
  parser.parse('"Tuesday is day " + (IndexOf(days,"Tuesday") + 1)');
  result = parser.evaluate();
  print(result); // Output: Tuesday is day 3
}
```

### Formula Simplification

Automatically simplify mathematical formulas for readability and optimization:

```dart
import 'package:quds_formula_parser/quds_formula_parser.dart';

void main() {
  FormulaParser parser = FormulaParser();
  parser.setVariableValue('x', 0);
  
  List<String> formulas = [
    'x + x',           // Simplifies to: 2 * x
    'x * 1',           // Simplifies to: x
    'x * 0',           // Simplifies to: 0
    'x^2 + x^2',       // Simplifies to: 2 * x ^ 2
    '2 * x + 3 * x',   // Simplifies to: 5 * x
    'x + x * 2',       // Simplifies to: 3 * x
  ];
  
  for (String formula in formulas) {
    var result = parser.parse(formula);
    print('$formula => ${result.formulaString}');
  }
}
```

### Creating Custom Functions

Extend the library with domain-specific functions:

```dart
import 'package:quds_formula_parser/quds_formula_parser.dart';
import 'dart:math';

void main() {
  // Create a custom provider
  FormulaProvider provider = FormulaProvider();
  provider.identifiers.addAll([
    BracketIdentifier(),
    NamedValuesIdentifier(provider: provider),
  ]);
  
  // Register a custom function
  provider.registerFunction(
    notations: ['Randomize', 'Custom.Rnd'],
    checkParameters: (params) => params.length == 1 && params.first is num,
    evaluator: (params) {
      return params.first * Random().nextInt(100);
    }
  );
  
  // Another custom function with result manipulation
  provider.registerFunction(
    notations: ['SinX'],
    checkParameters: (params) => params.length == 1 && params.first is num,
    evaluator: (params) => sin(params.first),
    manipulateResult: (r) => r.abs() < 1e-6 ? 0.0 : r,
  );
  
  // Use the parser with custom functions
  var parser = FormulaParser(provider: provider);
  provider.setVariableValue('x', 0);
  
  parser.parse('Randomize(x)');
  for (int i = 0; i < 5; i++) {
    provider.setVariableValue('x', i);
    print('Random(x=$i): ${parser.evaluate()}');
  }
}
```

### Setting Variables Dynamically

Change variable values using formulas:

```dart
import 'package:quds_formula_parser/quds_formula_parser.dart';

void main() {
  FormulaParser parser = FormulaParser();
  
  // Set a variable using a formula string
  parser.parse('SetVariable("y", 8)').evaluate();
  
  // Use the variable in another formula
  parser.parse('power(y, 2)').evaluate();
  var result = parser.evaluate();
  print('Result: $result'); // Output: 64
}
```

### Error Handling

Properly handle parsing errors with detailed information:

```dart
import 'package:quds_formula_parser/quds_formula_parser.dart';

void main() {
  FormulaParser parser = FormulaParser();
  
  List<String> formulas = [
    '5 + 9 / 2',       // Valid
    '4 + w5',          // Error: undefined term
    '4 +',             // Error: missing operand
    '4 + ()',          // Error: empty brackets
    '(4) + ((54)',     // Error: missing closing bracket
  ];
  
  for (String formula in formulas) {
    var result = parser.parse(formula);
    
    if (result.hasParsingError) {
      print('Error in "$formula":');
      print('  Position: ${result.errorParsingPosition}');
      print('  Type: ${result.errorCode?.name}');
    } else {
      var evaluated = parser.evaluate();
      print('$formula => $evaluated');
    }
  }
}
```

### Performance Optimization

For high-performance scenarios, parse formulas once and evaluate many times:

```dart
import 'package:quds_formula_parser/quds_formula_parser.dart';

void main() {
  FormulaParser parser = FormulaParser();
  parser.insertVariable(NamedValue(symbol: 'x', value: 0));
  
  // Parse the formula once
  String formulaStr = 'power(x, 2)';
  parser.parse(formulaStr);
  
  // Evaluate 1 million times with different values
  Stopwatch stopwatch = Stopwatch();
  stopwatch.start();
  
  const int times = 1000000;
  for (int i = 0; i < times; i++) {
    parser.setVariableValue('x', i);
    parser.evaluate();
  }
  
  stopwatch.stop();
  print('Evaluated $times times in ${stopwatch.elapsedMilliseconds}ms');
  print('Average time per evaluation: ${stopwatch.elapsedMilliseconds / times}ms');
}
```

### Advanced: Custom Identifiers and Operators

For advanced use cases, extend the library with custom identifiers:

```dart
import 'package:quds_formula_parser/quds_formula_parser.dart';

void main() {
  // Create custom provider with specific identifiers
  FormulaProvider provider = FormulaProvider();
  provider.identifiers.addAll([
    BracketIdentifier(),
    NamedValuesIdentifier(provider: provider),
    FunctionIdentifier(functions: []) // Add custom functions if needed
  ]);
  
  var parser = FormulaParser(provider: provider);
  
  // Parse and evaluate
  var result = parser.parse('(10 + 5) * 2').evaluate();
  print('Result: $result'); // Output: 30
}
```

## Real-World Examples

### Example 1: Grade Calculator

```dart
FormulaParser parser = FormulaParser();
parser.setVariables({'midterm': 75, 'final': 85, 'project': 90});
parser.parse('(midterm * 0.3) + (final * 0.5) + (project * 0.2)');
var grade = parser.evaluate();
print('Overall grade: $grade'); // Output: 82.5
```

### Example 2: Financial Calculation

```dart
FormulaParser parser = FormulaParser();
// Calculate compound interest: A = P(1 + r/n)^(nt)
parser.setVariables({
  'principal': 1000,
  'rate': 0.05,      // 5%
  'periods': 12,     // monthly
  'years': 5
});
parser.parse('principal * (1 + rate/periods) ^ (periods * years)');
var amount = parser.evaluate();
print('Final amount: \$$amount');
```

### Example 3: Geometric Calculations

```dart
FormulaParser parser = FormulaParser();
// Calculate area of triangle given three points
var area = parser.parse('Abs(((x1*(y2-y3) + x2*(y3-y1) + x3*(y1-y2))/2))').evaluate();
print('Triangle area: $area');
```

## Advanced Topics

### Extending with Custom Types

The package supports adding custom data types through custom identifiers and wrapper classes. You can register your own types by extending the identifier system and providing appropriate evaluation handlers.

### Performance Considerations

- **Parse Once, Evaluate Many**: For formulas used repeatedly, parse once and evaluate multiple times for optimal performance
- **Variable Caching**: Use the variable system to avoid re-parsing formulas with changing values
- **Function Registration**: Register frequently-used custom functions to avoid lookup overhead
- **Pre-compilation**: The package automatically optimizes formula representation during parsing

### Thread Safety

The `FormulaParser` and `FormulaProvider` classes maintain state. For multi-threaded applications, create separate parser instances for each thread or use appropriate synchronization mechanisms.

## API Reference

### Core Classes

- **FormulaParser**: Main class for parsing and evaluating formulas
- **FormulaProvider**: Manages functions, variables, and identifiers
- **FormulaInfixToPostfixConvertor**: Converts infix notation to postfix and evaluates
- **Formula**: Represents a parsed formula with error information
- **NamedValue**: Represents a variable with symbol and value

### Key Methods

- `parse(String formula)`: Parse a formula string
- `evaluate()`: Evaluate the last parsed formula
- `setVariableValue(String symbol, dynamic value)`: Set variable value
- `insertVariable(NamedValue variable)`: Define a new variable
- `registerFunction(...)`: Register a custom function

## Testing

The package includes comprehensive tests covering:
- Formula parsing and simplification
- All built-in functions and operators
- Custom function registration
- Variable operations
- Error handling and edge cases
- Performance benchmarks

Run tests with:

```bash
dart test
```

## Contributing

Contributions are welcome! To contribute:

1. Fork the repository
2. Create a feature branch for your changes
3. Add tests for new functionality
4. Submit a pull request with a clear description of your changes

Please ensure all tests pass before submitting a pull request.

## License

This package is licensed under the MIT License. See the LICENSE file for more information.

## Support

For issues, feature requests, or questions, please visit the [GitHub repository](https://github.com/MohammedAsaadAsaad/quds_formula_parser).

## Changelog

See the [CHANGELOG.md](CHANGELOG.md) file for version history and release notes.
