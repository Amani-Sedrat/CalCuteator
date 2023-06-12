import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _display = '';
  double _result = 0;

  void _updateDisplay(String value) {
    setState(() {
      _display += value;
    });
  }

  void _clearDisplay() {
    setState(() {
      _display = '';
      _result = 0;
    });
  }

  void _calculate() {
    setState(() {
      try {
        _result = evalExpression(_display);
        _display = _result.toString();
      } catch (e) {
        _display = 'Error';
      }
    });
  }

  double evalExpression(String expression) {
    List<String> parts = [];
    String currentPart = '';

    for (int i = 0; i < expression.length; i++) {
      String char = expression[i];

      if (char == '+' || char == '-' || char == '*' || char == '/') {
        parts.add(currentPart.trim());
        parts.add(char);
        currentPart = '';
      } else {
        currentPart += char;
      }
    }

    parts.add(currentPart.trim());

    double value = double.parse(parts[0]);

    for (int i = 1; i < parts.length; i += 2) {
      String operator = parts[i];
      double operand = double.parse(parts[i + 1]);

      switch (operator) {
        case '+':
          value += operand;
          break;
        case '-':
          value -= operand;
          break;
        case '*':
          value *= operand;
          break;
        case '/':
          value /= operand;
          break;
      }
    }

    return value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XffFFFFC2),
      body: Container(
        child: Column(
          children: [
            Image.asset("assets/stary.png"),
            Expanded(
              child: Container(
                alignment: Alignment.bottomRight,
                child: Text(
                  _display,
                  style: TextStyle(
                      fontSize: 48.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0Xff977FD7)),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _clearDisplay,
                style: ElevatedButton.styleFrom(
                  primary: Color(0Xff977FD7),
                ),
                child: Text(
                  'Clear Screen',
                  style: TextStyle(fontSize: 24.0, color: Color(0XFFF5A9CB)),
                ),
              ),
            ),
            Row(
              children: [
                _buildButton('7'),
                _buildButton('8'),
                _buildButton('9'),
                _buildButton('/'),
              ],
            ),
            Row(
              children: [
                _buildButton('4'),
                _buildButton('5'),
                _buildButton('6'),
                _buildButton('*'),
              ],
            ),
            Row(
              children: [
                _buildButton('1'),
                _buildButton('2'),
                _buildButton('3'),
                _buildButton('-'),
              ],
            ),
            Row(
              children: [
                _buildButton('0'),
                _buildButton('.'),
                _buildButton('='),
                _buildButton('+'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String value) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Color(0Xff7AD1FA), // Button background color

          padding: EdgeInsets.fromLTRB(16, 24, 16, 24), // Button padding
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0), // Button border radius
          ),
             
          elevation: 3.0, // Button elevation
          // Add any other desired styles or decorations
        ),
        onPressed: () {
          if (value == '=') {
            _calculate();
          } else {
            _updateDisplay(value);
          }
        },
        child: Text(
          value,
          style: TextStyle(fontSize: 24.0, color: Color(0XFF1F1946)),
        ),
      ),
    );
  }
}
