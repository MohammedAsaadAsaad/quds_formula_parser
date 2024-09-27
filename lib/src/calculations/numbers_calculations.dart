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
    for (int i = 1; i < length; i++) {
      if (elementAt(i) > result) result = elementAt(i);
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
    for (int i = 1; i < length; i++) {
      if (elementAt(i) < result) result = elementAt(i);
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
int gcd(int a, int b) {
  while (b != 0) {
    final t = b;
    b = a % b;
    a = t;
  }
  return a;
}
