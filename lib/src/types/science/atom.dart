import 'package:quds_formula_parser/quds_formula_parser.dart';

/// A class representing an atom with various properties like atomic number,
/// atomic weight, boiling/melting points, density, and more.
class Atom {
  /// The full name of the atom (e.g., "Hydrogen").
  final String name;

  /// The chemical symbol of the atom (e.g., "H").
  final String symbol;

  /// The atomic number of the atom (e.g., 1 for Hydrogen).
  final int atomicNumber;

  /// The atomic weight of the atom in grams per mole (g/mol).
  final double atomicWeight;

  /// The boiling point of the atom in degrees Celsius (°C).
  final double? boilingPoint;

  /// The melting point of the atom in degrees Celsius (°C).
  final double? meltingPoint;

  /// The density of the atom in grams per cubic centimeter (g/cm³).
  final double density;

  /// The ionization energy of the atom in electron volts (eV).
  final double ionizationEnergy;

  /// The row (or period) of the atom in the periodic table (optional).
  int? rowInPeriodicNumber;

  /// The column (or group) of the atom in the periodic table (optional).
  int? columnInPeriodicNumber;

  /// The percentage abundance of the atom in the Earth's crust.
  final double earthCrust;

  /// The year in which the atom was discovered.
  final int discoveryYear;

  /// The group number of the atom in the periodic table.
  final int groupNumber;

  /// Constructor to initialize an Atom with required properties and optional
  /// periodic table positioning (row/column).
  Atom({
    required this.name,
    required this.symbol,
    required this.atomicNumber,
    required this.atomicWeight,
    required this.boilingPoint,
    required this.meltingPoint,
    required this.density,
    required this.ionizationEnergy,
    this.rowInPeriodicNumber,
    this.columnInPeriodicNumber,
    required this.earthCrust,
    required this.discoveryYear,
    required this.groupNumber,
  }) {
    // Validation checks to ensure correct values.
    assert(atomicNumber > 0, "Atomic number must be positive.");
    assert(atomicWeight > 0, "Atomic weight must be positive.");
    assert(
        (boilingPoint == null || meltingPoint == null) ||
            (boilingPoint! > meltingPoint!),
        "Boiling point must be higher than melting point.");
  }

  /// Returns an atom from its chemical symbol (case-insensitive).
  static Atom? fromSymbol(String symbol) => _atomsMap[symbol.toLowerCase()];

  /// Provides a string representation of the atom.
  @override
  String toString() => '\'$symbol';

  /// Compares two atoms based on their atomic number for equality.
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! Atom) return false;
    return atomicNumber == other.atomicNumber;
  }

  /// Generates a unique hash code for the atom based on its atomic number.
  @override
  int get hashCode => atomicNumber.hashCode;

  /// Checks if the atom belongs to a specific period (row) in the periodic table.
  bool isInPeriod(int period) {
    return rowInPeriodicNumber == period;
  }

  /// Checks if the atom belongs to a specific group (column) in the periodic table.
  bool isInGroup(int group) {
    return groupNumber == group;
  }

  /// Creates a copy of the atom with optional modifications to its properties.
  Atom copyWith({
    String? name,
    String? symbol,
    int? atomicNumber,
    double? atomicWeight,
    double? boilingPoint,
    double? meltingPoint,
    double? density,
    double? ionizationEnergy,
    int? rowInPeriodicNumber,
    int? columnInPeriodicNumber,
    double? earthCrust,
    int? discoveryYear,
    int? groupNumber,
  }) {
    return Atom(
      name: name ?? this.name,
      symbol: symbol ?? this.symbol,
      atomicNumber: atomicNumber ?? this.atomicNumber,
      atomicWeight: atomicWeight ?? this.atomicWeight,
      boilingPoint: boilingPoint ?? this.boilingPoint,
      meltingPoint: meltingPoint ?? this.meltingPoint,
      density: density ?? this.density,
      ionizationEnergy: ionizationEnergy ?? this.ionizationEnergy,
      rowInPeriodicNumber: rowInPeriodicNumber ?? this.rowInPeriodicNumber,
      columnInPeriodicNumber:
          columnInPeriodicNumber ?? this.columnInPeriodicNumber,
      earthCrust: earthCrust ?? this.earthCrust,
      discoveryYear: discoveryYear ?? this.discoveryYear,
      groupNumber: groupNumber ?? this.groupNumber,
    );
  }

  /// Checks if the atom is classified as a metal based on its group number.
  /// Metals are generally located in groups 1 to 12 in the periodic table.
  bool isMetal() {
    return (groupNumber >= 1 && groupNumber <= 12);
  }

  /// Checks if the atom is classified as a non-metal based on its group number.
  /// Non-metals are generally located in groups 13 to 18 in the periodic table.
  bool isNonMetal() {
    return (groupNumber >= 13 && groupNumber <= 18);
  }
}

/// A wrapper class for handling `Atom` objects, extending from `ValueWrapper`.
/// This is used to encapsulate the optional `Atom` value and provide additional
/// functionality for viewing and determining the type of the value.
class AtomWrapper extends ValueWrapper<Atom?> {
  /// Constructor to initialize the wrapper with an `Atom` value, which can also be `null`.
  AtomWrapper(super.value);

  /// Returns the type of the value as a string, which is always `'Atom'`.
  @override
  String get valueType => 'Atom';

  /// Returns a string representation of the value for viewing purposes.
  /// If the value is `null`, it returns `'NULL'`; otherwise, it calls the `toString()`
  /// method of the `Atom` object.
  @override
  String get stringToView => value == null ? 'NULL' : value.toString();

  @override
  String get toTexNotation => stringToView;
}

final Map<String, Atom> _atomsMap = {
  'h': Atom(
      atomicNumber: 1,
      atomicWeight: 1.0079,
      name: "Hydrogen",
      symbol: "H",
      meltingPoint: -259,
      boilingPoint: -253,
      density: 0.09,
      earthCrust: 0.14,
      discoveryYear: 1776,
      groupNumber: 1,
      ionizationEnergy: 13.5984),
  'he': Atom(
      atomicNumber: 2,
      atomicWeight: 4.0026,
      name: "Helium",
      symbol: "He",
      meltingPoint: -272,
      boilingPoint: -269,
      density: 0.18,
      earthCrust: 0,
      discoveryYear: 1895,
      groupNumber: 18,
      ionizationEnergy: 24.5874),
  'li': Atom(
      atomicNumber: 3,
      atomicWeight: 6.941,
      name: "Lithium",
      symbol: "Li",
      meltingPoint: 180,
      boilingPoint: 1347,
      density: 0.53,
      earthCrust: 0,
      discoveryYear: 1817,
      groupNumber: 1,
      ionizationEnergy: 5.3917),
  'be': Atom(
      atomicNumber: 4,
      atomicWeight: 9.0122,
      name: "Beryllium",
      symbol: "Be",
      meltingPoint: 1278,
      boilingPoint: 2970,
      density: 1.85,
      earthCrust: 0,
      discoveryYear: 1797,
      groupNumber: 2,
      ionizationEnergy: 9.3227),
  'b': Atom(
      atomicNumber: 5,
      atomicWeight: 10.811,
      name: "Boron",
      symbol: "B",
      meltingPoint: 2300,
      boilingPoint: 2550,
      density: 2.34,
      earthCrust: 0,
      discoveryYear: 1808,
      groupNumber: 13,
      ionizationEnergy: 8.298),
  'c': Atom(
      atomicNumber: 6,
      atomicWeight: 12.0107,
      name: "Carbon",
      symbol: "C",
      meltingPoint: 3500,
      boilingPoint: 4827,
      density: 2.26,
      earthCrust: 0.094,
      discoveryYear: 0,
      groupNumber: 14,
      ionizationEnergy: 11.2603),
  'n': Atom(
      atomicNumber: 7,
      atomicWeight: 14.0067,
      name: "Nitrogen",
      symbol: "N",
      meltingPoint: -210,
      boilingPoint: -196,
      density: 1.25,
      earthCrust: 0,
      discoveryYear: 1772,
      groupNumber: 15,
      ionizationEnergy: 14.5341),
  'o': Atom(
      atomicNumber: 8,
      atomicWeight: 15.9994,
      name: "Oxygen",
      symbol: "O",
      meltingPoint: -218,
      boilingPoint: -183,
      density: 1.43,
      earthCrust: 46.71,
      discoveryYear: 1774,
      groupNumber: 16,
      ionizationEnergy: 13.6181),
  'f': Atom(
      atomicNumber: 9,
      atomicWeight: 18.9984,
      name: "Fluorine",
      symbol: "F",
      meltingPoint: -220,
      boilingPoint: -188,
      density: 1.7,
      earthCrust: 0.029,
      discoveryYear: 1886,
      groupNumber: 17,
      ionizationEnergy: 17.4228),
  'ne': Atom(
      atomicNumber: 10,
      atomicWeight: 20.1797,
      name: "Neon",
      symbol: "Ne",
      meltingPoint: -249,
      boilingPoint: -246,
      density: 0.9,
      earthCrust: 0,
      discoveryYear: 1898,
      groupNumber: 18,
      ionizationEnergy: 21.5645),
  'na': Atom(
      atomicNumber: 11,
      atomicWeight: 22.9897,
      name: "Sodium",
      symbol: "Na",
      meltingPoint: 98,
      boilingPoint: 883,
      density: 0.97,
      earthCrust: 2.75,
      discoveryYear: 1807,
      groupNumber: 1,
      ionizationEnergy: 5.1391),
  'mg': Atom(
      atomicNumber: 12,
      atomicWeight: 24.305,
      name: "Magnesium",
      symbol: "Mg",
      meltingPoint: 639,
      boilingPoint: 1090,
      density: 1.74,
      earthCrust: 2.08,
      discoveryYear: 1755,
      groupNumber: 2,
      ionizationEnergy: 7.6462),
  'al': Atom(
      atomicNumber: 13,
      atomicWeight: 26.9815,
      name: "Aluminum",
      symbol: "Al",
      meltingPoint: 660,
      boilingPoint: 2467,
      density: 2.7,
      earthCrust: 8.07,
      discoveryYear: 1825,
      groupNumber: 13,
      ionizationEnergy: 5.9858),
  'si': Atom(
      atomicNumber: 14,
      atomicWeight: 28.0855,
      name: "Silicon",
      symbol: "Si",
      meltingPoint: 1410,
      boilingPoint: 2355,
      density: 2.33,
      earthCrust: 27.69,
      discoveryYear: 1824,
      groupNumber: 14,
      ionizationEnergy: 8.1517),
  'p': Atom(
      atomicNumber: 15,
      atomicWeight: 30.9738,
      name: "Phosphorus",
      symbol: "P",
      meltingPoint: 44,
      boilingPoint: 280,
      density: 1.82,
      earthCrust: 0.13,
      discoveryYear: 1669,
      groupNumber: 15,
      ionizationEnergy: 10.4867),
  's': Atom(
      atomicNumber: 16,
      atomicWeight: 32.065,
      name: "Sulfur",
      symbol: "S",
      meltingPoint: 113,
      boilingPoint: 445,
      density: 2.07,
      earthCrust: 0.052,
      discoveryYear: 0,
      groupNumber: 16,
      ionizationEnergy: 10.36),
  'cl': Atom(
      atomicNumber: 17,
      atomicWeight: 35.453,
      name: "Chlorine",
      symbol: "Cl",
      meltingPoint: -101,
      boilingPoint: -35,
      density: 3.21,
      earthCrust: 0.045,
      discoveryYear: 1774,
      groupNumber: 17,
      ionizationEnergy: 12.9676),
  'ar': Atom(
      atomicNumber: 18,
      atomicWeight: 39.948,
      name: "Argon",
      symbol: "Ar",
      meltingPoint: -189,
      boilingPoint: -186,
      density: 1.78,
      earthCrust: 0,
      discoveryYear: 1894,
      groupNumber: 18,
      ionizationEnergy: 15.7596),
  'k': Atom(
      atomicNumber: 19,
      atomicWeight: 39.0983,
      name: "Potassium",
      symbol: "K",
      meltingPoint: 64,
      boilingPoint: 774,
      density: 0.86,
      earthCrust: 2.58,
      discoveryYear: 1807,
      groupNumber: 1,
      ionizationEnergy: 4.3407),
  'ca': Atom(
      atomicNumber: 20,
      atomicWeight: 40.078,
      name: "Calcium",
      symbol: "Ca",
      meltingPoint: 839,
      boilingPoint: 1484,
      density: 1.55,
      earthCrust: 3.65,
      discoveryYear: 1808,
      groupNumber: 2,
      ionizationEnergy: 6.1132),
  'sc': Atom(
      atomicNumber: 21,
      atomicWeight: 44.9559,
      name: "Scandium",
      symbol: "Sc",
      meltingPoint: 1539,
      boilingPoint: 2832,
      density: 2.99,
      earthCrust: 0,
      discoveryYear: 1879,
      groupNumber: 3,
      ionizationEnergy: 6.5615),
  'ti': Atom(
      atomicNumber: 22,
      atomicWeight: 47.867,
      name: "Titanium",
      symbol: "Ti",
      meltingPoint: 1660,
      boilingPoint: 3287,
      density: 4.54,
      earthCrust: 0.62,
      discoveryYear: 1791,
      groupNumber: 4,
      ionizationEnergy: 6.8281),
  'v': Atom(
      atomicNumber: 23,
      atomicWeight: 50.9415,
      name: "Vanadium",
      symbol: "V",
      meltingPoint: 1890,
      boilingPoint: 3380,
      density: 6.11,
      earthCrust: 0,
      discoveryYear: 1830,
      groupNumber: 5,
      ionizationEnergy: 6.7462),
  'cr': Atom(
      atomicNumber: 24,
      atomicWeight: 51.9961,
      name: "Chromium",
      symbol: "Cr",
      meltingPoint: 1857,
      boilingPoint: 2672,
      density: 7.19,
      earthCrust: 0.035,
      discoveryYear: 1797,
      groupNumber: 6,
      ionizationEnergy: 6.7665),
  'mn': Atom(
      atomicNumber: 25,
      atomicWeight: 54.938,
      name: "Manganese",
      symbol: "Mn",
      meltingPoint: 1245,
      boilingPoint: 1962,
      density: 7.43,
      earthCrust: 0.09,
      discoveryYear: 1774,
      groupNumber: 7,
      ionizationEnergy: 7.434),
  'fe': Atom(
      atomicNumber: 26,
      atomicWeight: 55.845,
      name: "Iron",
      symbol: "Fe",
      meltingPoint: 1535,
      boilingPoint: 2750,
      density: 7.87,
      earthCrust: 5.05,
      discoveryYear: 0,
      groupNumber: 8,
      ionizationEnergy: 7.9024),
  'co': Atom(
      atomicNumber: 27,
      atomicWeight: 58.9332,
      name: "Cobalt",
      symbol: "Co",
      meltingPoint: 1495,
      boilingPoint: 2870,
      density: 8.9,
      earthCrust: 0,
      discoveryYear: 1735,
      groupNumber: 9,
      ionizationEnergy: 7.881),
  'ni': Atom(
      atomicNumber: 28,
      atomicWeight: 58.6934,
      name: "Nickel",
      symbol: "Ni",
      meltingPoint: 1453,
      boilingPoint: 2732,
      density: 8.9,
      earthCrust: 0.019,
      discoveryYear: 1751,
      groupNumber: 10,
      ionizationEnergy: 7.6398),
  'cu': Atom(
      atomicNumber: 29,
      atomicWeight: 63.546,
      name: "Copper",
      symbol: "Cu",
      meltingPoint: 1083,
      boilingPoint: 2567,
      density: 8.96,
      earthCrust: 0,
      discoveryYear: 0,
      groupNumber: 11,
      ionizationEnergy: 7.7264),
  'zn': Atom(
      atomicNumber: 30,
      atomicWeight: 65.39,
      name: "Zinc",
      symbol: "Zn",
      meltingPoint: 420,
      boilingPoint: 907,
      density: 7.13,
      earthCrust: 0,
      discoveryYear: 0,
      groupNumber: 12,
      ionizationEnergy: 9.3942),
  'ga': Atom(
      atomicNumber: 31,
      atomicWeight: 69.723,
      name: "Gallium",
      symbol: "Ga",
      meltingPoint: 30,
      boilingPoint: 2403,
      density: 5.91,
      earthCrust: 0,
      discoveryYear: 1875,
      groupNumber: 13,
      ionizationEnergy: 5.9993),
  'ge': Atom(
      atomicNumber: 32,
      atomicWeight: 72.64,
      name: "Germanium",
      symbol: "Ge",
      meltingPoint: 937,
      boilingPoint: 2830,
      density: 5.32,
      earthCrust: 0,
      discoveryYear: 1886,
      groupNumber: 14,
      ionizationEnergy: 7.8994),
  'as': Atom(
      atomicNumber: 33,
      atomicWeight: 74.9216,
      name: "Arsenic",
      symbol: "As",
      meltingPoint: 81,
      boilingPoint: 613,
      density: 5.72,
      earthCrust: 0,
      discoveryYear: 0,
      groupNumber: 15,
      ionizationEnergy: 9.7886),
  'se': Atom(
      atomicNumber: 34,
      atomicWeight: 78.96,
      name: "Selenium",
      symbol: "Se",
      meltingPoint: 217,
      boilingPoint: 685,
      density: 4.79,
      earthCrust: 0,
      discoveryYear: 1817,
      groupNumber: 16,
      ionizationEnergy: 9.7524),
  'br': Atom(
      atomicNumber: 35,
      atomicWeight: 79.904,
      name: "Bromine",
      symbol: "Br",
      meltingPoint: -7,
      boilingPoint: 59,
      density: 3.12,
      earthCrust: 0,
      discoveryYear: 1826,
      groupNumber: 17,
      ionizationEnergy: 11.8138),
  'kr': Atom(
      atomicNumber: 36,
      atomicWeight: 83.8,
      name: "Krypton",
      symbol: "Kr",
      meltingPoint: -157,
      boilingPoint: -153,
      density: 3.75,
      earthCrust: 0,
      discoveryYear: 1898,
      groupNumber: 18,
      ionizationEnergy: 13.9996),
  'rb': Atom(
      atomicNumber: 37,
      atomicWeight: 85.4678,
      name: "Rubidium",
      symbol: "Rb",
      meltingPoint: 39,
      boilingPoint: 688,
      density: 1.63,
      earthCrust: 0,
      discoveryYear: 1861,
      groupNumber: 1,
      ionizationEnergy: 4.1771),
  'sr': Atom(
      atomicNumber: 38,
      atomicWeight: 87.62,
      name: "Strontium",
      symbol: "Sr",
      meltingPoint: 769,
      boilingPoint: 1384,
      density: 2.54,
      earthCrust: 0,
      discoveryYear: 1790,
      groupNumber: 2,
      ionizationEnergy: 5.6949),
  'y': Atom(
      atomicNumber: 39,
      atomicWeight: 88.9059,
      name: "Yttrium",
      symbol: "Y",
      meltingPoint: 1523,
      boilingPoint: 3337,
      density: 4.47,
      earthCrust: 0,
      discoveryYear: 1794,
      groupNumber: 3,
      ionizationEnergy: 6.2173),
  'zr': Atom(
      atomicNumber: 40,
      atomicWeight: 91.224,
      name: "Zirconium",
      symbol: "Zr",
      meltingPoint: 1852,
      boilingPoint: 4377,
      density: 6.51,
      earthCrust: 0.025,
      discoveryYear: 1789,
      groupNumber: 4,
      ionizationEnergy: 6.6339),
  'nb': Atom(
      atomicNumber: 41,
      atomicWeight: 92.9064,
      name: "Niobium",
      symbol: "Nb",
      meltingPoint: 2468,
      boilingPoint: 4927,
      density: 8.57,
      earthCrust: 0,
      discoveryYear: 1801,
      groupNumber: 5,
      ionizationEnergy: 6.7589),
  'mo': Atom(
      atomicNumber: 42,
      atomicWeight: 95.94,
      name: "Molybdenum",
      symbol: "Mo",
      meltingPoint: 2617,
      boilingPoint: 4612,
      density: 10.22,
      earthCrust: 0,
      discoveryYear: 1781,
      groupNumber: 6,
      ionizationEnergy: 7.0924),
  'tc': Atom(
      atomicNumber: 43,
      atomicWeight: 98,
      name: "Technetium",
      symbol: "Tc",
      meltingPoint: 2200,
      boilingPoint: 4877,
      density: 11.5,
      earthCrust: 0,
      discoveryYear: 1937,
      groupNumber: 7,
      ionizationEnergy: 7.28),
  'ru': Atom(
      atomicNumber: 44,
      atomicWeight: 101.07,
      name: "Ruthenium",
      symbol: "Ru",
      meltingPoint: 2250,
      boilingPoint: 3900,
      density: 12.37,
      earthCrust: 0,
      discoveryYear: 1844,
      groupNumber: 8,
      ionizationEnergy: 7.3605),
  'rh': Atom(
      atomicNumber: 45,
      atomicWeight: 102.9055,
      name: "Rhodium",
      symbol: "Rh",
      meltingPoint: 1966,
      boilingPoint: 3727,
      density: 12.41,
      earthCrust: 0,
      discoveryYear: 1803,
      groupNumber: 9,
      ionizationEnergy: 7.4589),
  'pd': Atom(
      atomicNumber: 46,
      atomicWeight: 106.42,
      name: "Palladium",
      symbol: "Pd",
      meltingPoint: 1552,
      boilingPoint: 2927,
      density: 12.02,
      earthCrust: 0,
      discoveryYear: 1803,
      groupNumber: 10,
      ionizationEnergy: 8.3369),
  'ag': Atom(
      atomicNumber: 47,
      atomicWeight: 107.8682,
      name: "Silver",
      symbol: "Ag",
      meltingPoint: 962,
      boilingPoint: 2212,
      density: 10.5,
      earthCrust: 0,
      discoveryYear: 0,
      groupNumber: 11,
      ionizationEnergy: 7.5762),
  'cd': Atom(
      atomicNumber: 48,
      atomicWeight: 112.411,
      name: "Cadmium",
      symbol: "Cd",
      meltingPoint: 321,
      boilingPoint: 765,
      density: 8.65,
      earthCrust: 0,
      discoveryYear: 1817,
      groupNumber: 12,
      ionizationEnergy: 8.9938),
  'in': Atom(
      atomicNumber: 49,
      atomicWeight: 114.818,
      name: "Indium",
      symbol: "In",
      meltingPoint: 157,
      boilingPoint: 2000,
      density: 7.31,
      earthCrust: 0,
      discoveryYear: 1863,
      groupNumber: 13,
      ionizationEnergy: 5.7864),
  'sn': Atom(
      atomicNumber: 50,
      atomicWeight: 118.71,
      name: "Tin",
      symbol: "Sn",
      meltingPoint: 232,
      boilingPoint: 2270,
      density: 7.31,
      earthCrust: 0,
      discoveryYear: 0,
      groupNumber: 14,
      ionizationEnergy: 7.3439),
  'sb': Atom(
      atomicNumber: 51,
      atomicWeight: 121.76,
      name: "Antimony",
      symbol: "Sb",
      meltingPoint: 630,
      boilingPoint: 1750,
      density: 6.68,
      earthCrust: 0,
      discoveryYear: 0,
      groupNumber: 15,
      ionizationEnergy: 8.6084),
  'te': Atom(
      atomicNumber: 52,
      atomicWeight: 127.6,
      name: "Tellurium",
      symbol: "Te",
      meltingPoint: 449,
      boilingPoint: 990,
      density: 6.24,
      earthCrust: 0,
      discoveryYear: 1783,
      groupNumber: 16,
      ionizationEnergy: 9.0096),
  'i': Atom(
      atomicNumber: 53,
      atomicWeight: 126.9045,
      name: "Iodine",
      symbol: "I",
      meltingPoint: 114,
      boilingPoint: 184,
      density: 4.93,
      earthCrust: 0,
      discoveryYear: 1811,
      groupNumber: 17,
      ionizationEnergy: 10.4513),
  'xe': Atom(
      atomicNumber: 54,
      atomicWeight: 131.293,
      name: "Xenon",
      symbol: "Xe",
      meltingPoint: -112,
      boilingPoint: -108,
      density: 5.9,
      earthCrust: 0,
      discoveryYear: 1898,
      groupNumber: 18,
      ionizationEnergy: 12.1298),
  'cs': Atom(
      atomicNumber: 55,
      atomicWeight: 132.9055,
      name: "Cesium",
      symbol: "Cs",
      meltingPoint: 29,
      boilingPoint: 678,
      density: 1.87,
      earthCrust: 0,
      discoveryYear: 1860,
      groupNumber: 1,
      ionizationEnergy: 3.8939),
  'ba': Atom(
      atomicNumber: 56,
      atomicWeight: 137.327,
      name: "Barium",
      symbol: "Ba",
      meltingPoint: 725,
      boilingPoint: 1140,
      density: 3.59,
      earthCrust: 0.05,
      discoveryYear: 1808,
      groupNumber: 2,
      ionizationEnergy: 5.2117),
  'la': Atom(
      atomicNumber: 57,
      atomicWeight: 138.9055,
      name: "Lanthanum",
      symbol: "La",
      meltingPoint: 920,
      boilingPoint: 3469,
      density: 6.15,
      earthCrust: 0,
      discoveryYear: 1839,
      groupNumber: 3,
      ionizationEnergy: 5.5769),
  'ce': Atom(
      atomicNumber: 58,
      atomicWeight: 140.116,
      name: "Cerium",
      symbol: "Ce",
      meltingPoint: 795,
      boilingPoint: 3257,
      density: 6.77,
      earthCrust: 0,
      discoveryYear: 1803,
      groupNumber: 101,
      ionizationEnergy: 5.5387),
  'pr': Atom(
      atomicNumber: 59,
      atomicWeight: 140.9077,
      name: "Praseodymium",
      symbol: "Pr",
      meltingPoint: 935,
      boilingPoint: 3127,
      density: 6.77,
      earthCrust: 0,
      discoveryYear: 1885,
      groupNumber: 101,
      ionizationEnergy: 5.473),
  'nd': Atom(
      atomicNumber: 60,
      atomicWeight: 144.24,
      name: "Neodymium",
      symbol: "Nd",
      meltingPoint: 1010,
      boilingPoint: 3127,
      density: 7.01,
      earthCrust: 0,
      discoveryYear: 1885,
      groupNumber: 101,
      ionizationEnergy: 5.525),
  'pm': Atom(
      atomicNumber: 61,
      atomicWeight: 145,
      name: "Promethium",
      symbol: "Pm",
      meltingPoint: 1100,
      boilingPoint: 3000,
      density: 7.3,
      earthCrust: 0,
      discoveryYear: 1945,
      groupNumber: 101,
      ionizationEnergy: 5.582),
  'sm': Atom(
      atomicNumber: 62,
      atomicWeight: 150.36,
      name: "Samarium",
      symbol: "Sm",
      meltingPoint: 1072,
      boilingPoint: 1900,
      density: 7.52,
      earthCrust: 0,
      discoveryYear: 1879,
      groupNumber: 101,
      ionizationEnergy: 5.6437),
  'eu': Atom(
      atomicNumber: 63,
      atomicWeight: 151.964,
      name: "Europium",
      symbol: "Eu",
      meltingPoint: 822,
      boilingPoint: 1597,
      density: 5.24,
      earthCrust: 0,
      discoveryYear: 1901,
      groupNumber: 101,
      ionizationEnergy: 5.6704),
  'gd': Atom(
      atomicNumber: 64,
      atomicWeight: 157.25,
      name: "Gadolinium",
      symbol: "Gd",
      meltingPoint: 1311,
      boilingPoint: 3233,
      density: 7.9,
      earthCrust: 0,
      discoveryYear: 1880,
      groupNumber: 101,
      ionizationEnergy: 6.1501),
  'tb': Atom(
      atomicNumber: 65,
      atomicWeight: 158.9253,
      name: "Terbium",
      symbol: "Tb",
      meltingPoint: 1360,
      boilingPoint: 3041,
      density: 8.23,
      earthCrust: 0,
      discoveryYear: 1843,
      groupNumber: 101,
      ionizationEnergy: 5.8638),
  'dy': Atom(
      atomicNumber: 66,
      atomicWeight: 162.5,
      name: "Dysprosium",
      symbol: "Dy",
      meltingPoint: 1412,
      boilingPoint: 2562,
      density: 8.55,
      earthCrust: 0,
      discoveryYear: 1886,
      groupNumber: 101,
      ionizationEnergy: 5.9389),
  'ho': Atom(
      atomicNumber: 67,
      atomicWeight: 164.9303,
      name: "Holmium",
      symbol: "Ho",
      meltingPoint: 1470,
      boilingPoint: 2720,
      density: 8.8,
      earthCrust: 0,
      discoveryYear: 1867,
      groupNumber: 101,
      ionizationEnergy: 6.0215),
  'er': Atom(
      atomicNumber: 68,
      atomicWeight: 167.259,
      name: "Erbium",
      symbol: "Er",
      meltingPoint: 1522,
      boilingPoint: 2510,
      density: 9.07,
      earthCrust: 0,
      discoveryYear: 1842,
      groupNumber: 101,
      ionizationEnergy: 6.1077),
  'tm': Atom(
      atomicNumber: 69,
      atomicWeight: 168.9342,
      name: "Thulium",
      symbol: "Tm",
      meltingPoint: 1545,
      boilingPoint: 1727,
      density: 9.32,
      earthCrust: 0,
      discoveryYear: 1879,
      groupNumber: 101,
      ionizationEnergy: 6.1843),
  'yb': Atom(
      atomicNumber: 70,
      atomicWeight: 173.04,
      name: "Ytterbium",
      symbol: "Yb",
      meltingPoint: 824,
      boilingPoint: 1466,
      density: 6.9,
      earthCrust: 0,
      discoveryYear: 1878,
      groupNumber: 101,
      ionizationEnergy: 6.2542),
  'lu': Atom(
      atomicNumber: 71,
      atomicWeight: 174.967,
      name: "Lutetium",
      symbol: "Lu",
      meltingPoint: 1656,
      boilingPoint: 3315,
      density: 9.84,
      earthCrust: 0,
      discoveryYear: 1907,
      groupNumber: 101,
      ionizationEnergy: 5.4259),
  'hf': Atom(
      atomicNumber: 72,
      atomicWeight: 178.49,
      name: "Hafnium",
      symbol: "Hf",
      meltingPoint: 2150,
      boilingPoint: 5400,
      density: 13.31,
      earthCrust: 0,
      discoveryYear: 1923,
      groupNumber: 4,
      ionizationEnergy: 6.8251),
  'ta': Atom(
      atomicNumber: 73,
      atomicWeight: 180.9479,
      name: "Tantalum",
      symbol: "Ta",
      meltingPoint: 2996,
      boilingPoint: 5425,
      density: 16.65,
      earthCrust: 0,
      discoveryYear: 1802,
      groupNumber: 5,
      ionizationEnergy: 7.5496),
  'w': Atom(
      atomicNumber: 74,
      atomicWeight: 183.84,
      name: "Tungsten",
      symbol: "W",
      meltingPoint: 3410,
      boilingPoint: 5660,
      density: 19.35,
      earthCrust: 0,
      discoveryYear: 1783,
      groupNumber: 6,
      ionizationEnergy: 7.864),
  're': Atom(
      atomicNumber: 75,
      atomicWeight: 186.207,
      name: "Rhenium",
      symbol: "Re",
      meltingPoint: 3180,
      boilingPoint: 5627,
      density: 21.04,
      earthCrust: 0,
      discoveryYear: 1925,
      groupNumber: 7,
      ionizationEnergy: 7.8335),
  'os': Atom(
      atomicNumber: 76,
      atomicWeight: 190.23,
      name: "Osmium",
      symbol: "Os",
      meltingPoint: 3045,
      boilingPoint: 5027,
      density: 22.6,
      earthCrust: 0,
      discoveryYear: 1803,
      groupNumber: 8,
      ionizationEnergy: 8.4382),
  'ir': Atom(
      atomicNumber: 77,
      atomicWeight: 192.217,
      name: "Iridium",
      symbol: "Ir",
      meltingPoint: 2410,
      boilingPoint: 4527,
      density: 22.4,
      earthCrust: 0,
      discoveryYear: 1803,
      groupNumber: 9,
      ionizationEnergy: 8.967),
  'pt': Atom(
      atomicNumber: 78,
      atomicWeight: 195.078,
      name: "Platinum",
      symbol: "Pt",
      meltingPoint: 1772,
      boilingPoint: 3827,
      density: 21.45,
      earthCrust: 0,
      discoveryYear: 1735,
      groupNumber: 10,
      ionizationEnergy: 8.9587),
  'au': Atom(
      atomicNumber: 79,
      atomicWeight: 196.9665,
      name: "Gold",
      symbol: "Au",
      meltingPoint: 1064,
      boilingPoint: 2807,
      density: 19.32,
      earthCrust: 0,
      discoveryYear: 0,
      groupNumber: 11,
      ionizationEnergy: 9.2255),
  'hg': Atom(
      atomicNumber: 80,
      atomicWeight: 200.59,
      name: "Mercury",
      symbol: "Hg",
      meltingPoint: -39,
      boilingPoint: 357,
      density: 13.55,
      earthCrust: 0,
      discoveryYear: 0,
      groupNumber: 12,
      ionizationEnergy: 10.4375),
  'tl': Atom(
      atomicNumber: 81,
      atomicWeight: 204.3833,
      name: "Thallium",
      symbol: "Tl",
      meltingPoint: 303,
      boilingPoint: 1457,
      density: 11.85,
      earthCrust: 0,
      discoveryYear: 1861,
      groupNumber: 13,
      ionizationEnergy: 6.1082),
  'pb': Atom(
      atomicNumber: 82,
      atomicWeight: 207.2,
      name: "Lead",
      symbol: "Pb",
      meltingPoint: 327,
      boilingPoint: 1740,
      density: 11.35,
      earthCrust: 0,
      discoveryYear: 0,
      groupNumber: 14,
      ionizationEnergy: 7.4167),
  'bi': Atom(
      atomicNumber: 83,
      atomicWeight: 208.9804,
      name: "Bismuth",
      symbol: "Bi",
      meltingPoint: 271,
      boilingPoint: 1560,
      density: 9.75,
      earthCrust: 0,
      discoveryYear: 0,
      groupNumber: 15,
      ionizationEnergy: 7.2856),
  'po': Atom(
      atomicNumber: 84,
      atomicWeight: 209,
      name: "Polonium",
      symbol: "Po",
      meltingPoint: 254,
      boilingPoint: 962,
      density: 9.3,
      earthCrust: 0,
      discoveryYear: 1898,
      groupNumber: 16,
      ionizationEnergy: 8.417),
  'at': Atom(
      atomicNumber: 85,
      atomicWeight: 210,
      name: "Astatine",
      symbol: "At",
      meltingPoint: 302,
      boilingPoint: 337,
      density: 0,
      earthCrust: 0,
      discoveryYear: 1940,
      groupNumber: 17,
      ionizationEnergy: 9.3),
  'rn': Atom(
      atomicNumber: 86,
      atomicWeight: 222,
      name: "Radon",
      symbol: "Rn",
      meltingPoint: -71,
      boilingPoint: -62,
      density: 9.73,
      earthCrust: 0,
      discoveryYear: 1900,
      groupNumber: 18,
      ionizationEnergy: 10.7485),
  'fr': Atom(
      atomicNumber: 87,
      atomicWeight: 223,
      name: "Francium",
      symbol: "Fr",
      meltingPoint: 27,
      boilingPoint: 677,
      density: 0,
      earthCrust: 0,
      discoveryYear: 1939,
      groupNumber: 1,
      ionizationEnergy: 4.0727),
  'ra': Atom(
      atomicNumber: 88,
      atomicWeight: 226,
      name: "Radium",
      symbol: "Ra",
      meltingPoint: 700,
      boilingPoint: 1737,
      density: 5.5,
      earthCrust: 0,
      discoveryYear: 1898,
      groupNumber: 2,
      ionizationEnergy: 5.2784),
  'ac': Atom(
      atomicNumber: 89,
      atomicWeight: 227,
      name: "Actinium",
      symbol: "Ac",
      meltingPoint: 1050,
      boilingPoint: 3200,
      density: 10.07,
      earthCrust: 0,
      discoveryYear: 1899,
      groupNumber: 3,
      ionizationEnergy: 5.17),
  'th': Atom(
      atomicNumber: 90,
      atomicWeight: 232.0381,
      name: "Thorium",
      symbol: "Th",
      meltingPoint: 1750,
      boilingPoint: 4790,
      density: 11.72,
      earthCrust: 0,
      discoveryYear: 1829,
      groupNumber: 102,
      ionizationEnergy: 6.3067),
  'pa': Atom(
      atomicNumber: 91,
      atomicWeight: 231.0359,
      name: "Protactinium",
      symbol: "Pa",
      meltingPoint: 1568,
      boilingPoint: 4000,
      density: 15.4,
      earthCrust: 0,
      discoveryYear: 1913,
      groupNumber: 102,
      ionizationEnergy: 5.89),
  'u': Atom(
      atomicNumber: 92,
      atomicWeight: 238.0289,
      name: "Uranium",
      symbol: "U",
      meltingPoint: 1132,
      boilingPoint: 3818,
      density: 18.95,
      earthCrust: 0,
      discoveryYear: 1789,
      groupNumber: 102,
      ionizationEnergy: 6.1941),
  'np': Atom(
      atomicNumber: 93,
      atomicWeight: 237,
      name: "Neptunium",
      symbol: "Np",
      meltingPoint: 640,
      boilingPoint: 3902,
      density: 20.2,
      earthCrust: 0,
      discoveryYear: 1940,
      groupNumber: 102,
      ionizationEnergy: 6.2657),
  'pu': Atom(
      atomicNumber: 94,
      atomicWeight: 244,
      name: "Plutonium",
      symbol: "Pu",
      meltingPoint: 640,
      boilingPoint: 3235,
      density: 19.84,
      earthCrust: 0,
      discoveryYear: 1940,
      groupNumber: 102,
      ionizationEnergy: 6.0262),
  'am': Atom(
      atomicNumber: 95,
      atomicWeight: 243,
      name: "Americium",
      symbol: "Am",
      meltingPoint: 994,
      boilingPoint: 2607,
      density: 13.67,
      earthCrust: 0,
      discoveryYear: 1944,
      groupNumber: 102,
      ionizationEnergy: 5.9738),
  'cm': Atom(
      atomicNumber: 96,
      atomicWeight: 247,
      name: "Curium",
      symbol: "Cm",
      meltingPoint: 1340,
      boilingPoint: 3110,
      density: 13.5,
      earthCrust: 0,
      discoveryYear: 1944,
      groupNumber: 102,
      ionizationEnergy: 5.9915),
  'bk': Atom(
      atomicNumber: 97,
      atomicWeight: 247,
      name: "Berkelium",
      symbol: "Bk",
      meltingPoint: 986,
      boilingPoint: 2900,
      density: 14.78,
      earthCrust: 0,
      discoveryYear: 1949,
      groupNumber: 102,
      ionizationEnergy: 6.1979),
  'cf': Atom(
      atomicNumber: 98,
      atomicWeight: 251,
      name: "Californium",
      symbol: "Cf",
      meltingPoint: 900,
      boilingPoint: 14700,
      density: 15.1,
      earthCrust: 0,
      discoveryYear: 1950,
      groupNumber: 102,
      ionizationEnergy: 6.2817),
  'es': Atom(
      atomicNumber: 99,
      atomicWeight: 252,
      name: "Einsteinium",
      symbol: "Es",
      meltingPoint: 860,
      boilingPoint: 996,
      density: 0,
      earthCrust: 0,
      discoveryYear: 1952,
      groupNumber: 102,
      ionizationEnergy: 6.42),
  'fm': Atom(
      atomicNumber: 100,
      atomicWeight: 257,
      name: "Fermium",
      symbol: "Fm",
      meltingPoint: 1527,
      boilingPoint:
          null, //Unkown due to he high temperatures required to boil fermium
      density: 0,
      earthCrust: 0,
      discoveryYear: 1952,
      groupNumber: 102,
      ionizationEnergy: 6.5),
  'md': Atom(
      atomicNumber: 101,
      atomicWeight: 258,
      name: "Mendelevium",
      symbol: "Md",
      meltingPoint: 827,
      boilingPoint: null,
      density: 0,
      earthCrust: 0,
      discoveryYear: 1955,
      groupNumber: 102,
      ionizationEnergy: 6.58),
  'no': Atom(
      atomicNumber: 102,
      atomicWeight: 259,
      name: "Nobelium",
      symbol: "No",
      meltingPoint: 827,
      boilingPoint: null,
      density: 0,
      earthCrust: 0,
      discoveryYear: 1958,
      groupNumber: 102,
      ionizationEnergy: 6.65),
  'lr': Atom(
      atomicNumber: 103,
      atomicWeight: 262,
      name: "Lawrencium",
      symbol: "Lr",
      meltingPoint: 1627,
      boilingPoint: null,
      density: 0,
      earthCrust: 0,
      discoveryYear: 1961,
      groupNumber: 102,
      ionizationEnergy: 4.9),
  'rf': Atom(
      atomicNumber: 104,
      atomicWeight: 261,
      name: "Rutherfordium",
      symbol: "Rf",
      meltingPoint: 2100,
      boilingPoint: 5500,
      density: 0,
      earthCrust: 0,
      discoveryYear: 1964,
      groupNumber: 4,
      ionizationEnergy: 0),
  'db': Atom(
      atomicNumber: 105,
      atomicWeight: 262,
      name: "Dubnium",
      symbol: "Db",
      meltingPoint: null,
      boilingPoint: null,
      density: 0,
      earthCrust: 0,
      discoveryYear: 1967,
      groupNumber: 5,
      ionizationEnergy: 0),
  'sg': Atom(
      atomicNumber: 106,
      atomicWeight: 266,
      name: "Seaborgium",
      symbol: "Sg",
      meltingPoint: null,
      boilingPoint: null,
      density: 0,
      earthCrust: 0,
      discoveryYear: 1974,
      groupNumber: 6,
      ionizationEnergy: 0),
  'bh': Atom(
      atomicNumber: 107,
      atomicWeight: 264,
      name: "Bohrium",
      symbol: "Bh",
      meltingPoint: null,
      boilingPoint: null,
      density: 0,
      earthCrust: 0,
      discoveryYear: 1981,
      groupNumber: 7,
      ionizationEnergy: 0),
  'hs': Atom(
      atomicNumber: 108,
      atomicWeight: 277,
      name: "Hassium",
      symbol: "Hs",
      meltingPoint: 819,
      boilingPoint: 1196,
      density: 0,
      earthCrust: 0,
      discoveryYear: 1984,
      groupNumber: 8,
      ionizationEnergy: 0),
  'mt': Atom(
      atomicNumber: 109,
      atomicWeight: 268,
      name: "Meitnerium",
      symbol: "Mt",
      meltingPoint: null,
      boilingPoint: null,
      density: 0,
      earthCrust: 0,
      discoveryYear: 1982,
      groupNumber: 9,
      ionizationEnergy: 0),
};
