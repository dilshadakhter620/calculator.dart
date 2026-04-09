import 'package:flutter/material.dart';

void main() => runApp(const CalculatorApp());

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = "0";
  String _expression = "";
  double _num1 = 0;
  double _num2 = 0;
  String _operand = "";

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "CLEAR") {
        _output = "0";
        _expression = "";
        _num1 = 0;
        _num2 = 0;
        _operand = "";
      } else if (buttonText == "+" || buttonText == "-" || buttonText == "×" || buttonText == "÷") {
        _num1 = double.parse(_output);
        _operand = buttonText;
        _expression = _output + buttonText;
        _output = "0";
      } else if (buttonText == ".") {
        if (_output.contains(".")) return;
        _output = _output + buttonText;
      } else if (buttonText == "=") {
        _num2 = double.parse(_output);
        _expression += _output;

        if (_operand == "+") _output = (_num1 + _num2).toString();
        if (_operand == "-") _output = (_num1 - _num2).toString();
        if (_operand == "×") _output = (_num1 * _num2).toString();
        if (_operand == "÷") _output = (_num1 / _num2).toString();

        _num1 = 0;
        _num2 = 0;
        _operand = "";
        
        // Clean up trailing .0
        if(_output.endsWith(".0")) _output = _output.substring(0, _output.length - 2);
      } else {
        _output = _output == "0" ? buttonText : _output + buttonText;
      }
    });
  }

  Widget buildButton(String text, Color color) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(24),
            backgroundColor: color,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          onPressed: () => buttonPressed(text),
          child: Text(text, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(_expression, style: const TextStyle(fontSize: 24, color: Colors.grey)),
                  Text(_output, style: const TextStyle(fontSize: 60, fontWeight: FontWeight.bold, color: Colors.white)),
                ],
              ),
            ),
          ),
          Column(children: [
            Row(children: [buildButton("7", Colors.grey[850]!), buildButton("8", Colors.grey[850]!), buildButton("9", Colors.grey[850]!), buildButton("÷", Colors.orange)]),
            Row(children: [buildButton("4", Colors.grey[850]!), buildButton("5", Colors.grey[850]!), buildButton("6", Colors.grey[850]!), buildButton("×", Colors.orange)]),
            Row(children: [buildButton("1", Colors.grey[850]!), buildButton("2", Colors.grey[850]!), buildButton("3", Colors.grey[850]!), buildButton("-", Colors.orange)]),
            Row(children: [buildButton(".", Colors.grey[850]!), buildButton("0", Colors.grey[850]!), buildButton("CLEAR", Colors.redAccent), buildButton("+", Colors.orange)]),
            Row(children: [buildButton("=", Colors.green)]),
          ])
        ],
      ),
    );
  }
}