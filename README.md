
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

### 1. **Numbers**:

-   **Real Numbers**: Represented by classes like `RealNumber` and other numerical utilities.
-   **Complex Numbers**: Handling of complex numbers through the `ComplexNumber` class.
-   **Boolean/Logic**: Boolean values are managed through `BooleanWrapper` and related logic types.

### 2. **Date and Time**:

-   **Date**: Managed by the `Date` class for handling date-related functionalities.
-   **Time**: Handled by the `Time` class for time manipulations.
-   **Duration**: Represented by the `QudsDuration` class for handling time spans.
-   **DateTime**: `QudsDateTime` class adds specific custom handling for datetime operations.

### 3. **Math and Geometry**:

-   **2D Point**: Handled by the `Point2D` class, which represents a point in a two-dimensional space.
-   **3D Point**: Handled by the `Point3D` class for three-dimensional geometry.

### 4. **Strings**:

-   **Strings**: Managed by `StringWrapper` and `Strings` classes for string manipulation.

### 5. **Science**:

-   **Atom**: Scientific data types related to chemistry and atomic structure represented by the `Atom` class.


----------
### **Operators (Defined in the Package)**:

The following operators are implemented within the parsing logic:

1.  **Arithmetic Operators**:
    
    -   `+` : Addition
    -   `-` : Subtraction
    -   `*` : Multiplication
    -   `/` : Division
    -   `^` : Exponentiation (raising to a power)
2.  **Relational Operators**:
    
    -   `=` : Equal to
    -   `<>` : Not equal to
    -   `>` : Greater than
    -   `<` : Less than
    -   `>=` : Greater than or equal to
    -   `<=` : Less than or equal to

 
----------

### **Functions (Defined in the Package)**:

The following are functions that are specifically implemented within the codebase.

### **Type & Value Checking Functions**

-   **Type**: Returns the data type of the input.
-   **IsNumber**: Checks if the input is a number.
-   **IsReal**: Determines if the input is a real number.
-   **IsComplex**: Verifies if the input is a complex number.
-   **IsText**: Checks if the input is a string.
-   **IsNA**: Identifies if the input is "not available".
-   **IsNull**: Determines if the input is null.

### **Date & Time Functions**

-   **Today**: Returns the current date.
-   **Now**: Returns the current date and time.
-   **Date**: Creates a date from provided values.
-   **Year**: Extracts the year from a date.
-   **Month**: Extracts the month from a date.
-   **Day**: Extracts the day from a date.
-   **WeekDay**: Returns the day of the week for a date.
-   **Days**: Calculates the difference in days between two dates.

### **Logical & Conditional Functions**

-   **And**: Logical AND operation.
-   **IfError**: Returns a value if an error occurs.
-   **If**: Evaluates a condition and returns a value based on true or false.
-   **Not**: Logical negation (NOT operation).
-   **Or**: Logical OR operation.

### **Geometry & Distance Functions**

-   **Distance**: Calculates the distance between two points.
-   **PointX**: Returns the X coordinate of a point.
-   **PointY**: Returns the Y coordinate of a point.
-   **PointZ**: Returns the Z coordinate of a point.
-   **Point**: Creates a point from coordinates.

### **Statistical & Aggregation Functions**

-   **Sum**: Adds a list of numbers.
-   **Average**: Calculates the average of numbers.
-   **Product**: Multiplies a list of numbers.
-   **Count**: Counts the number of items.
-   **Max**: Finds the maximum value.
-   **Min**: Finds the minimum value.
-   **Median**: Returns the median value.
-   **StandardDeviation**: Calculates the standard deviation of numbers.
-   **Variance**: Returns the variance of a list of numbers.

### **Mathematical Functions**

-   **Abs**: Returns the absolute value of a number.
-   **Mod**: Returns the remainder after division.
-   **Round**: Rounds a number to specified decimal places.
-   **Int**: Returns the integer part of a number.
-   **Power**: Raises a number to a specified power.
-   **SqRt**: Calculates the square root of a number.
-   **Log**: Computes the logarithm of a number.
-   **Exp**: Returns `e` raised to the power of a number.
-   **Sin**: Returns the sine of an angle.
-   **Cos**: Returns the cosine of an angle.
-   **Tan**: Returns the tangent of an angle.

### **Atom Functions (Scientific Functions)**

-   **Atom**: Represents an atom in calculations.
-   **AtomName**: Returns the name of an atom.
-   **AtomSymbol**: Returns the atomic symbol.
-   **AtomicNumber**: Returns the atomic number.
-   **AtomicWeight**: Returns the atomic weight.
-   **BoilingPoint**: Returns the boiling point of an atom.
-   **MeltingPoint**: Returns the melting point of an atom.
-   **AtomDensity**: Returns the density of an atom.
-   **AtomIonizationEnergy**: Returns the ionization energy of an atom.
-   **AtomRowInTable**: Returns the row of an atom in the periodic table.
-   **AtomColumnInTable**: Returns the column of an atom in the periodic table.
-   **AtomEarthCrust**: Returns the abundance of an atom in the Earth's crust.
-   **AtomDiscoveryYear**: Returns the year the atom was discovered.
-   **AtomGroupNumber**: Returns the group number of an atom in the periodic table.

### **String Functions**

-   **StringLength**: Returns the length of a string.
-   **StringConcat**: Concatenates multiple strings.
-   **ToUpper**: Converts a string to uppercase.
-   **ToLower**: Converts a string to lowercase.
-   **Trim**: Removes spaces from both sides of a string.
-   **TrimLeft**: Removes spaces from the left side of a string.
-   **TrimRight**: Removes spaces from the right side of a string.

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