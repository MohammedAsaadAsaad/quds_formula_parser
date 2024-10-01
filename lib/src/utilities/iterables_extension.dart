/// An extension that adds utility methods for checking and accessing elements
/// from iterable collections. This extension can be applied to any `Iterable<T>`,
/// where `T` is the type of elements in the collection.
extension IterablesExtension<T> on Iterable<T> {
  /// Checks if the iterable contains exactly one element.
  ///
  /// **Returns**:
  /// - `true` if the iterable has exactly one element.
  bool get isSingle => length == 1;

  /// Checks if the iterable contains exactly two elements.
  ///
  /// **Returns**:
  /// - `true` if the iterable has exactly two elements.
  bool get isCouple => length == 2;

  /// Checks if the iterable contains exactly three elements.
  ///
  /// **Returns**:
  /// - `true` if the iterable has exactly three elements.
  bool get isTriple => length == 3;

  /// Returns the second element in the iterable.
  ///
  /// **Throws**:
  /// - `RangeError` if the iterable has fewer than two elements.
  T get second => elementAt(1);

  /// Returns the third element in the iterable.
  ///
  /// **Throws**:
  /// - `RangeError` if the iterable has fewer than three elements.
  T get third => elementAt(2);

  /// Returns the fourth element in the iterable.
  ///
  /// **Throws**:
  /// - `RangeError` if the iterable has fewer than four elements.
  T get fourth => elementAt(3);

  /// Returns the fifth element in the iterable.
  ///
  /// **Throws**:
  /// - `RangeError` if the iterable has fewer than five elements.
  T get fifth => elementAt(4);

  /// Returns the sixth element in the iterable.
  ///
  /// **Throws**:
  /// - `RangeError` if the iterable has fewer than six elements.
  T get sixth => elementAt(5);
}
