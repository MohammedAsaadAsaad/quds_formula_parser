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
        return params.first * Random().nextInt(100);
      },
      manipulateResult: (r) =>
          r.abs() < 1e-6 ? 0.0 : r);
```,
      