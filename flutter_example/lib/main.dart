import 'package:flutter/material.dart';
import 'package:quds_formula_parser/quds_formula_parser.dart';

import 'plot_2d.dart';

/// The main entry point of the application.
void main() {
  runApp(const MyApp());
}

/// The root widget of the application.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  /// Builds the main MaterialApp for the application.
  ///
  /// This includes setting the app's title and theme, and defining the
  /// [MyHomePage] widget as the home screen.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quds Formula Parser',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Quds Formula Parser'),
    );
  }
}

/// The main homepage widget with a state.
///
/// Displays a text field for entering a formula and plots the result
/// using the `FormulaPlot` widget.
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  /// The title of the home page.
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

/// The state class for [MyHomePage].
class _MyHomePageState extends State<MyHomePage> {
  /// The provider used to evaluate formulas.
  late FormulaProvider provider = FormulaProvider.defaultInstance;

  /// Controller for handling the text input of the formula.
  TextEditingController formulaController =
      TextEditingController(text: 'x * Sin(x)');

  /// FocusNode for managing focus on the formula input field.
  FocusNode formulaFocus = FocusNode();

  /// The parser that handles formula evaluation.
  late FormulaParser parser = FormulaParser(provider: provider);

  /// Converts infix formulas to postfix for easier evaluation.
  FormulaInfixToPostfixConvertor? supporter;

  /// The parsed formula.
  Formula? formula;

  /// Refreshes the plot by parsing the formula and updating the UI.
  void refreshThePlot() {
    setState(() {
      var str = formulaController.text;
      formula = parser.parse(str);
      supporter = FormulaInfixToPostfixConvertor(formula: formula!);
    });
  }

  /// Initializes the state and sets up the default variable `x`.
  @override
  void initState() {
    provider.insertVariable(Variable(symbol: 'x', value: 0));
    super.initState();
  }

  /// Builds the UI of the home page.
  ///
  /// The UI contains an AppBar, a text field for formula input, and the plot.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(100),
        child: Column(
          children: [
            _buildFormula(), // Builds the formula input field
            const SizedBox(height: 5),
            Expanded(child: _buildPlot()) // Displays the plot
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: refreshThePlot, // Refreshes the plot when clicked
        tooltip: 'Calculate',
        child: const Icon(Icons.auto_graph_outlined),
      ),
    );
  }

  /// Builds the text field for formula input.
  ///
  /// The user can type a mathematical formula that will be parsed and plotted.
  Widget _buildFormula() {
    return TextField(
      controller: formulaController,
      focusNode: formulaFocus,
      autofocus: true,
    );
  }

  /// Builds the plot area where the graph is displayed.
  ///
  /// The plot is updated based on the formula entered in the text field.
  Widget _buildPlot() {
    return supporter == null
        ? const SizedBox() // If no formula is entered, display an empty space
        : Center(
            child: FormulaPlot(
              evaluator: (x) {
                // Sets the value of 'x' and evaluates the formula
                provider.setVariableValue('x', x);
                var result = supporter!.evaluate().value;
                return result;
              },
            ),
          );
  }
}
