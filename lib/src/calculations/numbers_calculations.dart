import 'dart:math';

/// Extension methods for iterable collections of numeric values.
extension NumbersCalculations on Iterable<num> {
  /// Returns the count of elements in the iterable.
  num count() => length;

  /// Returns the sum of the elements in the iterable.
  ///
  /// Returns `null` if the iterable is empty. Uses [reduce] to sum up
  /// the elements.
  num? sum() {
    if (isEmpty) return null;
    return reduce((a, b) => a + b);
  }

  /// Returns the average of the elements in the iterable.
  ///
  /// Returns `null` if the iterable is empty. The average is calculated
  /// by dividing the sum of the elements by the count.
  num? average() {
    if (isEmpty) return null;
    return sum()! / length;
  }

  /// Returns the maximum value from the iterable.
  ///
  /// Returns `null` if the iterable is empty. Iterates through the
  /// elements and tracks the maximum value found.
  num? max() {
    if (isEmpty) return null;
    num result = first;
    for (var value in this) {
      if (value > result) result = value;
    }
    return result;
  }

  /// Returns the minimum value from the iterable.
  ///
  /// Returns `null` if the iterable is empty. Iterates through the
  /// elements and tracks the minimum value found.
  num? min() {
    if (isEmpty) return null;
    num result = first;
    for (var value in this) {
      if (value < result) result = value;
    }
    return result;
  }

  /// Returns the median of the elements in the iterable.
  ///
  /// Returns `null` if the iterable is empty. The list is sorted, and
  /// the median is calculated based on whether the length is odd or even.
  num? median() {
    if (isEmpty) return null;

    // Step 1: Sort the list
    var lst = toList()..sort();

    int length = lst.length;

    // Step 2: Check if the list length is odd or even
    if (length % 2 == 1) {
      // If odd, return the middle element
      return lst[length ~/ 2];
    } else {
      // If even, return the average of the two middle elements
      return ((lst[length ~/ 2 - 1] + lst[length ~/ 2]) / 2);
    }
  }

  /// Returns the mode (most frequent value) from the iterable.
  ///
  /// Returns `null` if the iterable is empty. Iterates through the
  /// elements and counts the frequency of each value.
  num? mode() {
    if (isEmpty) return null;

    Map<num, int> frequency = {};
    num? mode;
    int maxCount = 0;

    for (var value in this) {
      frequency[value] = (frequency[value] ?? 0) + 1;
      if (frequency[value]! > maxCount) {
        maxCount = frequency[value]!;
        mode = value;
      }
    }

    return mode;
  }

  /// Returns the standard deviation of the elements in the iterable.
  ///
  /// Returns `null` if the iterable is empty. The standard deviation is
  /// calculated as the square root of the variance.
  num? standardDeviation() => isEmpty ? null : sqrt(variance()!);

  /// Returns the variance of the elements in the iterable.
  ///
  /// Returns `null` if the iterable is empty. The variance is calculated
  /// as the average of the squared differences from the mean.
  num? variance() {
    if (isEmpty) return null;

    var mean = average()!;
    return map((e) => pow(e - mean, 2)).average();
  }
}

/// Helper function to compute GCD (Greatest Common Divisor)
///
/// The GCD is calculated using the Euclidean algorithm.
int gcd(int a, int b) {
  while (b != 0) {
    final t = b;
    b = a % b;
    a = t;
  }
  return a;
}

/// Helper function to compute LCM (Least Common Multiplier)
///
/// LCM is calculated as the absolute value of the product of the two numbers
/// divided by their GCD.
int lcm(int a, int b) {
  var result = (a * b) / gcd(a, b);
  return result < 0 ? -result.toInt() : result.toInt();
}

/// Returns the hyperbolic cosine of [x].
num cosh(num x) => (pow(e, x) + pow(e, -x)) / 2.0;

/// Returns the hyperbolic sine of [x].
num sinh(num x) => (pow(e, x) - pow(e, -x)) / 2.0;

/// Returns the hyperbolic tangent of [x].
num tanh(num x) => sinh(x) / cosh(x);

/// Returns the factorial of [n].
///
/// Factorial is calculated as the product of all positive integers less
/// than or equal to [n].
int factorial(int n) {
  if (n < 0) {
    throw ArgumentError('Factorial is not defined for negative numbers.');
  }

  int result = 1;
  for (int i = 2; i <= n; i++) {
    result *= i;
  }
  return result;
}

/// Checks if a number [n] is prime.
///
/// Returns `true` if [n] is prime, `false` otherwise.
bool isPrime(int n) {
  if (n < 2) return false;
  for (int i = 2; i <= sqrt(n); i++) {
    if (n % i == 0) return false;
  }
  return true;
}

/// Returns the nth Fibonacci number.
///
/// Uses an iterative approach to calculate the nth Fibonacci number.
int fibonacci(int n) {
  if (n == 0) return 0;
  if (n == 1) return 1;

  int prev1 = 0;
  int prev2 = 1;
  int current = 0;

  for (int i = 2; i <= n; i++) {
    current = prev1 + prev2;
    prev1 = prev2;
    prev2 = current;
  }

  return current;
}

/// Returns the number of permutations of [n] items taken [r] at a time.
///
/// The number of permutations is calculated as `n! / (n - r)!`.
int permutations(int n, int r) {
  return factorial(n) ~/ factorial(n - r);
}

/// Returns the number of combinations of [n] items taken [r] at a time.
///
/// The number of combinations is calculated as `n! / (r!(n - r)!)`.
int combinations(int n, int r) {
  return factorial(n) ~/ (factorial(r) * factorial(n - r));
}

/// Clamps [value] between [min] and [max].
///
/// If [value] is less than [min], [min] is returned. If [value] is greater
/// than [max], [max] is returned. Otherwise, [value] is returned.
num clamp(num value, num min, num max) {
  if (value < min) return min;
  if (value > max) return max;
  return value;
}
