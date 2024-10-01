import 'package:quds_formula_parser/quds_formula_parser.dart';

/// Registers atom-related functions with the provided formula provider.
///
/// This function defines and registers operations that retrieve properties
/// of chemical elements (atoms) such as their name, symbol, atomic number,
/// atomic weight, and other properties from the periodic table.
///
/// **Parameters**:
/// - [provider]: The `FormulaProvider` instance where the atom-related functions are registered.
void registerAtomsFunctions(FormulaProvider provider) {
  // Register the function to create an Atom from its symbol.
  provider.registerFunction(
      notations: ['Atom'],
      evaluator: (params) => Atom.fromSymbol(params.first),
      checkParameters: (params) => params.isSingle && params.first is String);

  // Helper function to define atom-related functions that retrieve atom properties.
  void defineAtomFunction(
      List<String> notations, dynamic Function(Atom atom) evaluate) {
    provider.registerFunction(
        notations: notations,
        evaluator: (params) => evaluate(params.first),
        checkParameters: (params) => params.isSingle && params.first is Atom);
  }

  // Register functions to retrieve various atom properties.
  defineAtomFunction(['Atom.Name', 'AtomName'], (atom) => atom.name);
  defineAtomFunction(['Atom.Symbol', 'AtomSymbol'], (atom) => atom.symbol);
  defineAtomFunction(['Atom.Number', 'Atom.AtomicNumber', 'AtomicNumber'],
      (atom) => atom.atomicNumber);
  defineAtomFunction(['Atom.Weight', 'AtomicWeight', 'Atom.AtomicWeight'],
      (atom) => atom.atomicWeight);
  defineAtomFunction(
      ['Atom.BoilingPoint', 'BoilingPoint'], (atom) => atom.boilingPoint);
  defineAtomFunction(
      ['Atom.MeltingPoint', 'MeltingPoint'], (atom) => atom.meltingPoint);
  defineAtomFunction(['Atom.Density', 'AtomDensity'], (atom) => atom.density);
  defineAtomFunction(['Atom.IonizationEnergy', 'AtomIonizationEnergy'],
      (atom) => atom.ionizationEnergy);
  defineAtomFunction(
      ['Atom.Row', 'AtomRow'], (atom) => atom.rowInPeriodicNumber);
  defineAtomFunction(
      ['Atom.Column', 'AtomColumn'], (atom) => atom.columnInPeriodicNumber);
  defineAtomFunction(
      ['Atom.EarthCrust', 'AtomEarthCrust'], (atom) => atom.earthCrust);
  defineAtomFunction(['Atom.DiscoveryYear', 'AtomDiscoveryYear'],
      (atom) => atom.discoveryYear);
  defineAtomFunction(
      ['Atom.GroupNumber', 'Atom.AtomGroupNumber', 'AtomGroupNumber'],
      (atom) => atom.groupNumber);
}
