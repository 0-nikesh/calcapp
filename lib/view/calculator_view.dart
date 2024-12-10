import 'package:flutter/material.dart';

class CalculatorView extends StatefulWidget {
  const CalculatorView({super.key});

  @override
  State<CalculatorView> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  final _textController = TextEditingController();
  List<String> lstSymbols = [
    "C",
    "←",
    "%",
    "/",
    "7",
    "8",
    "9",
    "*",
    "4",
    "5",
    "6",
    "-",
    "1",
    "2",
    "3",
    "+",
    "±",
    "0",
    ".",
    "=",
  ];

  String? firstOperand;
  String? operator;
  String? secondOperand;

  void _onButtonPressed(String symbol) {
    setState(() {
      if (symbol == "C") {
        _textController.clear();
        firstOperand = null;
        operator = null;
        secondOperand = null;
      } else if (symbol == "←") {
        if (_textController.text.isNotEmpty) {
          _textController.text = _textController.text
              .substring(0, _textController.text.length - 1);
        }
      } else if (symbol == "=") {
        if (firstOperand != null &&
            operator != null &&
            _textController.text.isNotEmpty) {
          secondOperand = _textController.text;
          _calculateResult();
        }
      } else if ("+-*/%".contains(symbol)) {
        if (_textController.text.isNotEmpty) {
          firstOperand = _textController.text;
          operator = symbol;
          _textController.clear();
        }
      } else if (symbol == "±") {
        if (_textController.text.isNotEmpty) {
          double currentValue = double.tryParse(_textController.text) ?? 0;
          _textController.text = (-currentValue).toString();
        }
      } else {
        _textController.text += symbol;
      }
    });
  }

  void _calculateResult() {
    double num1 = double.tryParse(firstOperand ?? "0") ?? 0;
    double num2 = double.tryParse(secondOperand ?? "0") ?? 0;
    double result = 0;

    switch (operator) {
      case "+":
        result = num1 + num2;
        break;
      case "-":
        result = num1 - num2;
        break;
      case "*":
        result = num1 * num2;
        break;
      case "/":
        result = num2 != 0 ? num1 / num2 : 0; // Prevent division by zero
        break;
      case "%":
        result = num1 % num2;
        break;
    }

    _textController.text = result.toString();
    firstOperand = null;
    operator = null;
    secondOperand = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 241, 235, 235),
      appBar: AppBar(
        title: Center(child: const Text('Nikesh Calculator')),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Display Area
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                _textController.text,
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 16),
            // Buttons Grid
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 12.0,
                  mainAxisSpacing: 12.0,
                ),
                itemCount: lstSymbols.length,
                itemBuilder: (context, index) {
                  String symbol = lstSymbols[index];
                  bool isOperator = "+-*/%=←C±=".contains(symbol);

                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isOperator
                          ? const Color.fromARGB(255, 45, 38, 254)
                          : const Color.fromARGB(255, 12, 186, 255),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(16.0),
                    ),
                    onPressed: () => _onButtonPressed(symbol),
                    child: Text(
                      symbol,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: isOperator ? Colors.white : Colors.white70,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
