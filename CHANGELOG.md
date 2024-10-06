## 0.0.1
- Initial version.

## 0.0.2
- Updated the packege to fit the pub scores creteria.

## 0.0.3
- Updated the packege to fit the pub scores creteria.

## 0.0.4
- Added support of fraction type.
- Simplified the usage of the provider
- Simplified the registration of new function
```dart
  provider.registerFunction(
      notations: ['Randomize', 'Custom.Rnd'],
      evaluator: (params) {
        return params.first * Random().nextInt(100);
      },
      checkParameters: (params) => params.length == 1 && params.first is num);
```

- Added manipulating method 
```dart
  provider.registerFunction(
      notations: ['SinX'],
      checkParameters: (params) => params.length == 1 && params.first is num,
      evaluator: (params) {
        return sin(params.first);
      },
      manipulateResult: (r) =>
          r.abs() < 1e-6 ? 0.0 : r);
```

## 0.0.5
- Created an extension on `Iterable<T>` to perform quick queries on iterables like `isSingle`, `isCouple`, `isTriple`, `second`, `third`, `fourth`, `fifth`.

- Support new functions: 
>+ Mathematical: `Random`, `ASin`, `ACos`, `ATan`, `ATan2`, `Root`, `RandomInt`, `RandomDouble`, `GCD`, `LCM`, `IsPrime`.
>+ Statisticals: `Permutations`, `Combinations`, `Mode`.
>+ Geometry: `IsPoint`, `IsPoint2D`, `IsPoint3D`.
>+ Core: `IsDate`, `IsTime`, `IsDateTime`, `IsDuration`, `IsBool`, `IsFraction`, `IsAtom`.
>+ Date & Time: `Hour`, `Minute`, `Second`.
>+ Logical: `XOR`, `Toggle`, `AllTrue`, `AnyTrue`, `AllFalse`, `AnyFalse`, `RandomBool`.
>+ Iterables: `List`, `Reverse`, `Set`, `Intersect`, `Union`, `Differnce`.

- Support new constants: 
>+ Mathematical: `ln10`, `ln2`, `log2e`, `log10e`, `sqrt1_2`, `sqrt2`.

- Support new types: 
>+ `Iterables` with `IterableWrapper` as its values wrapper.

- Simplified some functions registrations.

## 0.0.6
- Simplified the bodies of most of operators.
- Defined new functions:`MemberAt`, `IndexOf`.
- Developed the 2d plotter example.