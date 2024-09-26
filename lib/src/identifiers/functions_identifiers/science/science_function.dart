import 'package:quds_formula_parser/quds_formula_parser.dart';

/// An abstract class representing science-related functions.
///
/// This class serves as a base for various functions related to scientific data,
/// particularly focusing on atomic properties and related calculations.
///
/// Functions that inherit from this class include:
/// - AtomFunction
/// - AtomNameFunction
/// - AtomSymbolFunction
/// - AtomicNumberFunction
/// - AtomicWeightFunction
/// - BoilingPointFunction
/// - MeltingPointFunction
/// - AtomDensityFunction
/// - AtomIonizationEnergyFunction
/// - AtomRowInTableFunction
/// - AtomColumnInTableFunction
/// - AtomEarthCrustFunction
/// - AtomDiscoveryYearFunction
/// - AtomGroupNumberFunction
abstract class ScienceFunction extends FormulaFunction {
  ScienceFunction({required super.functionNotations});

  /// Generates a list of science-related functions.
  ///
  /// These functions include:
  /// - `AtomFunction`: Represents a general atomic calculation.
  /// - `AtomNameFunction`: Returns the name of an atom.
  /// - `AtomSymbolFunction`: Returns the symbol of an atom.
  /// - `AtomicNumberFunction`: Returns the atomic number of an atom.
  /// - `AtomicWeightFunction`: Returns the atomic weight of an atom.
  /// - `BoilingPointFunction`: Returns the boiling point of an atom.
  /// - `MeltingPointFunction`: Returns the melting point of an atom.
  /// - `AtomDensityFunction`: Returns the density of an atom.
  /// - `AtomIonizationEnergyFunction`: Returns the ionization energy of an atom.
  /// - `AtomRowInTableFunction`: Returns the row of an atom in the periodic table.
  /// - `AtomColumnInTableFunction`: Returns the column of an atom in the periodic table.
  /// - `AtomEarthCrustFunction`: Returns the abundance of an atom in the Earth's crust.
  /// - `AtomDiscoveryYearFunction`: Returns the year an atom was discovered.
  /// - `AtomGroupNumberFunction`: Returns the group number of an atom in the periodic table.
  static List<ScienceFunction> generateFunctions() => [
        AtomFunction(),
        AtomNameFunction(),
        AtomSymbolFunction(),
        AtomicNumberFunction(),
        AtomicWeightFunction(),
        BoilingPointFunction(),
        MeltingPointFunction(),
        AtomDensityFunction(),
        AtomIonizationEnergyFunction(),
        AtomRowInTableFunction(),
        AtomColumnInTableFunction(),
        AtomEarthCrustFunction(),
        AtomDiscoveryYearFunction(),
        AtomGroupNumberFunction(),
      ];
}
