import 'package:quds_formula_parser/quds_formula_parser.dart';

/// A function to retrieve an atom based on its symbol.
///
/// This function accepts a string representing the atomic symbol and returns
/// the corresponding [Atom] object.
///
/// Function notations:
/// - 'Atom'
class AtomFunction extends ScienceFunction {
  AtomFunction()
      : super(functionNotations: [
          'Atom',
        ]);

  /// Retrieves the atom corresponding to the given symbol.
  ///
  /// Takes a string as input and returns the corresponding [Atom] object.
  @override
  calculate(List<ValueWrapper> parameters) {
    var value = parameters.first.value;
    if (value is String) {
      var atom = Atom.fromSymbol(value);
      return atom;
    }
    return NAValue();
  }

  /// Checks if the provided parameters are valid for atom retrieval.
  @override
  bool checkParameters(List<ValueWrapper> terms) => terms.length == 1;
}

/// A function to retrieve the name of an atom.
///
/// This function returns the name of an atom based on the provided [Atom] object.
///
/// Function notations:
/// - 'AtomName'
/// - 'Atom.Name'
class AtomNameFunction extends ScienceFunction {
  AtomNameFunction()
      : super(functionNotations: [
          'Atom.Name',
          'AtomName',
        ]);

  /// Retrieves the name of the given atom.
  @override
  calculate(List<ValueWrapper> parameters) {
    var value = parameters.first.value;
    if (value is Atom) {
      return value.name;
    }
    return NAValue();
  }

  /// Checks if the provided parameters are valid for atom name retrieval.
  @override
  bool checkParameters(List<ValueWrapper> terms) =>
      terms.length == 1 || terms.first.value is Atom;
}

/// A function to retrieve the symbol of an atom.
///
/// This function returns the atomic symbol of the provided [Atom] object.
///
/// Function notations:
/// - 'AtomSymbol'
/// - 'Atom.Symbol'
class AtomSymbolFunction extends ScienceFunction {
  AtomSymbolFunction()
      : super(functionNotations: [
          'Atom.Symbol',
          'AtomSymbol',
        ]);

  /// Retrieves the atomic symbol of the given atom.
  @override
  calculate(List<ValueWrapper> parameters) {
    var value = parameters.first.value;
    if (value is Atom) {
      return value.symbol;
    }
    return NAValue();
  }

  /// Checks if the provided parameters are valid for atom symbol retrieval.
  @override
  bool checkParameters(List<ValueWrapper> terms) =>
      terms.length == 1 || terms.first.value is Atom;
}

/// A function to retrieve the atomic number of an atom.
///
/// This function returns the atomic number of the provided [Atom] object.
///
/// Function notations:
/// - 'AtomicNumber'
/// - 'Atom.AtomicNumber'
class AtomicNumberFunction extends ScienceFunction {
  AtomicNumberFunction()
      : super(functionNotations: [
          'Atom.Number',
          'Atom.AtomicNumber',
          'AtomicNumber',
        ]);

  /// Retrieves the atomic number of the given atom.
  @override
  calculate(List<ValueWrapper> parameters) {
    var value = parameters.first.value;
    if (value is Atom) {
      return value.atomicNumber;
    }
    return NAValue();
  }

  /// Checks if the provided parameters are valid for atomic number retrieval.
  @override
  bool checkParameters(List<ValueWrapper> terms) =>
      terms.length == 1 || terms.first.value is Atom;
}

/// A function to retrieve the atomic weight of an atom.
///
/// This function returns the atomic weight of the provided [Atom] object.
///
/// Function notations:
/// - 'AtomicWeight'
/// - 'Atom.AtomicWeight'
/// - 'Atom.Weight'
class AtomicWeightFunction extends ScienceFunction {
  AtomicWeightFunction()
      : super(functionNotations: [
          'Atom.Weight',
          'AtomicWeight',
          'Atom.AtomicWeight',
        ]);

  /// Retrieves the atomic weight of the given atom.
  @override
  calculate(List<ValueWrapper> parameters) {
    var value = parameters.first.value;
    if (value is Atom) {
      return value.atomicWeight;
    }
    return NAValue();
  }

  /// Checks if the provided parameters are valid for atomic weight retrieval.
  @override
  bool checkParameters(List<ValueWrapper> terms) =>
      terms.length == 1 || terms.first.value is Atom;
}

/// A function to retrieve the boiling point of an atom.
///
/// This function returns the boiling point of the provided [Atom] object.
///
/// Function notations:
/// - 'BoilingPoint'
/// - 'Atom.BoilingPoint'
class BoilingPointFunction extends ScienceFunction {
  BoilingPointFunction()
      : super(functionNotations: [
          'Atom.BoilingPoint',
          'BoilingPoint',
        ]);

  /// Retrieves the boiling point of the given atom.
  @override
  calculate(List<ValueWrapper> parameters) {
    var value = parameters.first.value;
    if (value is Atom) {
      return value.boilingPoint;
    }
    return NAValue();
  }

  /// Checks if the provided parameters are valid for boiling point retrieval.
  @override
  bool checkParameters(List<ValueWrapper> terms) =>
      terms.length == 1 || terms.first.value is Atom;
}

/// A function to retrieve the melting point of an atom.
///
/// This function returns the melting point of the provided [Atom] object.
///
/// Function notations:
/// - 'MeltingPoint'
/// - 'Atom.MeltingPoint'
class MeltingPointFunction extends ScienceFunction {
  MeltingPointFunction()
      : super(functionNotations: [
          'Atom.MeltingPoint',
          'MeltingPoint',
        ]);

  /// Retrieves the melting point of the given atom.
  @override
  calculate(List<ValueWrapper> parameters) {
    var value = parameters.first.value;
    if (value is Atom) {
      return value.meltingPoint;
    }
    return NAValue();
  }

  /// Checks if the provided parameters are valid for melting point retrieval.
  @override
  bool checkParameters(List<ValueWrapper> terms) =>
      terms.length == 1 || terms.first.value is Atom;
}

/// A function to retrieve the density of an atom.
///
/// This function returns the density of the provided [Atom] object.
///
/// Function notations:
/// - 'AtomDensity'
/// - 'Atom.Density'
class AtomDensityFunction extends ScienceFunction {
  AtomDensityFunction()
      : super(functionNotations: [
          'Atom.Density',
          'AtomDensity',
        ]);

  /// Retrieves the density of the given atom.
  @override
  calculate(List<ValueWrapper> parameters) {
    var value = parameters.first.value;
    if (value is Atom) {
      return value.density;
    }
    return NAValue();
  }

  /// Checks if the provided parameters are valid for atom density retrieval.
  @override
  bool checkParameters(List<ValueWrapper> terms) =>
      terms.length == 1 || terms.first.value is Atom;
}

/// A function to retrieve the ionization energy of an atom.
///
/// This function returns the ionization energy of the provided [Atom] object.
///
/// Function notations:
/// - 'AtomIonizationEnergy'
/// - 'Atom.IonizationEnergy'
class AtomIonizationEnergyFunction extends ScienceFunction {
  AtomIonizationEnergyFunction()
      : super(functionNotations: [
          'Atom.IonizationEnergy',
          'AtomIonizationEnergy',
        ]);

  /// Retrieves the ionization energy of the given atom.
  @override
  calculate(List<ValueWrapper> parameters) {
    var value = parameters.first.value;
    if (value is Atom) {
      return value.ionizationEnergy;
    }
    return NAValue();
  }

  /// Checks if the provided parameters are valid for ionization energy retrieval.
  @override
  bool checkParameters(List<ValueWrapper> terms) =>
      terms.length == 1 || terms.first.value is Atom;
}

/// A function to retrieve the row of an atom in the periodic table.
///
/// This function returns the row number of the provided [Atom] object in the periodic table.
///
/// Function notations:
/// - 'AtomRow'
/// - 'Atom.Row'
class AtomRowInTableFunction extends ScienceFunction {
  AtomRowInTableFunction()
      : super(functionNotations: [
          'Atom.Row',
          'AtomRow',
        ]);

  /// Retrieves the row of the given atom in the periodic table.
  @override
  calculate(List<ValueWrapper> parameters) {
    var value = parameters.first.value;
    if (value is Atom) {
      return value.rowInPeriodicNumber;
    }
    return NAValue();
  }

  /// Checks if the provided parameters are valid for periodic table row retrieval.
  @override
  bool checkParameters(List<ValueWrapper> terms) =>
      terms.length == 1 || terms.first.value is Atom;
}

/// A function to retrieve the column of an atom in the periodic table.
///
/// This function returns the column number of the provided [Atom] object in the periodic table.
///
/// Function notations:
/// - 'AtomColumn'
/// - 'Atom.Column'
class AtomColumnInTableFunction extends ScienceFunction {
  AtomColumnInTableFunction()
      : super(functionNotations: [
          'Atom.Column',
          'AtomColumn',
        ]);

  /// Retrieves the column of the given atom in the periodic table.
  @override
  calculate(List<ValueWrapper> parameters) {
    var value = parameters.first.value;
    if (value is Atom) {
      return value.columnInPeriodicNumber;
    }
    return NAValue();
  }

  /// Checks if the provided parameters are valid for periodic table column retrieval.
  @override
  bool checkParameters(List<ValueWrapper> terms) =>
      terms.length == 1 || terms.first.value is Atom;
}

/// A function to retrieve the abundance of an atom in the Earth's crust.
///
/// This function returns the percentage abundance of the provided [Atom] object in the Earth's crust.
///
/// Function notations:
/// - 'AtomEarthCrust'
/// - 'Atom.EarthCrust'
class AtomEarthCrustFunction extends ScienceFunction {
  AtomEarthCrustFunction()
      : super(functionNotations: [
          'Atom.EarthCrust',
          'AtomEarchCrust',
        ]);

  /// Retrieves the abundance of the given atom in the Earth's crust.
  @override
  calculate(List<ValueWrapper> parameters) {
    var value = parameters.first.value;
    if (value is Atom) {
      return value.earthCrust;
    }
    return NAValue();
  }

  /// Checks if the provided parameters are valid for Earth's crust abundance retrieval.
  @override
  bool checkParameters(List<ValueWrapper> terms) =>
      terms.length == 1 || terms.first.value is Atom;
}

/// A function to retrieve the discovery year of an atom.
///
/// This function returns the year in which the provided [Atom] object was discovered.
///
/// Function notations:
/// - 'AtomDiscoveryYear'
/// - 'Atom.DiscoveryYear'
class AtomDiscoveryYearFunction extends ScienceFunction {
  AtomDiscoveryYearFunction()
      : super(functionNotations: [
          'Atom.DiscoveryYear',
          'AtomDiscoveryYear',
        ]);

  /// Retrieves the discovery year of the given atom.
  @override
  calculate(List<ValueWrapper> parameters) {
    var value = parameters.first.value;
    if (value is Atom) {
      return value.discoveryYear;
    }
    return NAValue();
  }

  /// Checks if the provided parameters are valid for atom discovery year retrieval.
  @override
  bool checkParameters(List<ValueWrapper> terms) =>
      terms.length == 1 || terms.first.value is Atom;
}

/// A function to retrieve the group number of an atom.
///
/// This function returns the group number of the provided [Atom] object in the periodic table.
///
/// Function notations:
/// - 'AtomGroupNumber'
/// - 'Atom.AtomGroupNumber'
class AtomGroupNumberFunction extends ScienceFunction {
  AtomGroupNumberFunction()
      : super(functionNotations: [
          'Atom.GroupNumber',
          'Atom.AtomGroupNumber',
          'AtomGroupNumber',
        ]);

  /// Retrieves the group number of the given atom in the periodic table.
  @override
  calculate(List<ValueWrapper> parameters) {
    var value = parameters.first.value;
    if (value is Atom) {
      return value.groupNumber;
    }
    return NAValue();
  }

  /// Checks if the provided parameters are valid for atom group number retrieval.
  @override
  bool checkParameters(List<ValueWrapper> terms) =>
      terms.length == 1 || terms.first.value is Atom;
}
