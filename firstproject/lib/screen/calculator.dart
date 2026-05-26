// ignore_for_file: unused_element

import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => CalculatorScreenState();
}

class CalculatorScreenState extends State<CalculatorScreen> {
  String display = '0';
  String expression = '';
  double firstNumber = 0;
  double secondNumber = 0;
  String operator = '';
  bool freshInput = false;

  // ────────────────────────────────────────
  // TODO: initState (10 points)
  // Set the following default values:
  // display = '0'
  // expression = ''
  // operator = ''
  // freshInput = false
  // HINT: call super.initState() first
  // ────────────────────────────────────────
  @override
  void initState() {
    super.initState();
    // Remove nested setState, assign directly
    display = '0';
    expression = '';
    operator = '';
    freshInput = false;
  }

  // ────────────────────────────────────────
  // TODO: onNumber() (20 points)
  // Called when a number button is tapped
  // Use if / else:
  // if display is '0' OR freshInput is true:
  // set display = number, set freshInput = false
  // else:
  // append number to display (display = display + number)
  // Wrap everything inside setState()
  // ────────────────────────────────────────
  void onNumber(String number) {
    setState(() {
      if (display == '0' || freshInput == true) {
        display = number;
        freshInput = false;
      } else {
        display = display + number;
      }
    });
  }

  // ────────────────────────────────────────
  // TODO: onOperator() (20 points)
  // Called when +, -, x, or / is tapped
  // Inside setState():
  // 1. Parse display into firstNumber using double.tryParse()
  // 2. Set operator = op
  // 3. Set expression = '$display $op'
  // 4. Set freshInput = true
  // ────────────────────────────────────────
  void onOperator(String op) {
    setState(() {
      firstNumber = double.tryParse(display) ?? 0;
      operator = op;
      expression = '$display $op';
      freshInput = true;
    });
  }

  // ────────────────────────────────────────
  // TODO: onEquals() (40 points)
  // Called when = is tapped
  // Step 1: if operator is empty, return (do nothing)
  // Step 2: Parse display into secondNumber using double.tryParse()
  // Step 3: Use if / else if to compute result:
  // operator '+' → firstNumber + secondNumber
  // operator '-' → firstNumber - secondNumber
  // operator 'x' → firstNumber * secondNumber
  // operator '/' → firstNumber / secondNumber
  // if secondNumber is 0: set display = 'Error', clear operator, return
  // Step 4: Update expression = '$expression $display ='
  // Step 5: if result has no decimal (result == result.truncateToDouble()):
  // display = result.toInt().toString()
  // else:
  // display = result.toStringAsFixed(6).replaceAll(RegExp(r'0+$'), '')
  // Step 6: Set operator = '', freshInput = true
  // Wrap everything in setState()
  // ────────────────────────────────────────
  void onEquals() {
    if (operator.isEmpty) return;

    setState(() {
      secondNumber = double.tryParse(display) ?? 0;
      double result = 0;

      if (operator == '+') {
        result = firstNumber + secondNumber;
      } else if (operator == '-') {
        result = firstNumber - secondNumber;
      } else if (operator == 'x') {
        result = firstNumber * secondNumber;
      } else if (operator == '/') {
        if (secondNumber == 0) {
          display = 'Error';
          operator = '';
          return;
        }
        result = firstNumber / secondNumber;
      }

      expression = '$expression $display =';

      if (result == result.truncateToDouble()) {
        display = result.toInt().toString();
      } else {
        display = result.toStringAsFixed(6).replaceAll(RegExp(r'0+$'), '');
      }

      operator = '';
      freshInput = true;
    });
  }

  // ────────────────────────────────────────
  // TODO: onClear() (10 points)
  // Reset everything back to default inside setState():
  // display = '0'
  // expression = ''
  // firstNumber = 0
  // secondNumber = 0
  // operator = ''
  // freshInput = false
  // ────────────────────────────────────────
  void onClear() {
    setState(() {
      display = '0';
      expression = '';
      firstNumber = 0;
      secondNumber = 0;
      operator = '';
      freshInput = false;
    });
  }

  // ── Already done for you ──
  void onDecimal() {
    setState(() {
      if (freshInput) {
        display = '0.';
        freshInput = false;
        return;
      }
      if (!display.contains('.')) {
        display = '$display.';
      }
    });
  }

  void onToggleSign() {
    setState(() {
      double current = double.tryParse(display) ?? 0;
      current = current * -1;
      if (current == current.truncateToDouble()) {
        display = current.toInt().toString();
      } else {
        display = current.toString();
      }
    });
  }

  void onPercent() {
    setState(() {
      double current = double.tryParse(display) ?? 0;
      current = current / 100;
      display = current.toString();
    });
  }

  void onBackspace() {
    setState(() {
      if (display.length <= 1 || display == 'Error') {
        display = '0';
      } else {
        display = display.substring(0, display.length - 1);
      }
    });
  }

  // ── Button builder — do not edit ──
  Widget calcButton({
    required String label,
    required VoidCallback onTap,
    Color bgColor = const Color(0xFF2D2D2D),
    Color textColor = Colors.white,
    double flex = 1,
  }) {
    return Expanded(
      flex: flex.toInt(),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Material(
          color: bgColor,
          borderRadius: BorderRadius.circular(50),
          child: InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: onTap,
            child: Container(
              height: 72,
              alignment: Alignment.center,
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                  color: textColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color darkBtn = Color(0xFF2D2D2D);
    const Color grayBtn = Color(0xFF636363);
    const Color orange = Color(0xFFFF9500);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // ── Display — do not edit ──
            Expanded(
              child: Container(
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      expression,
                      style: const TextStyle(
                        color: Colors.white38,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    const SizedBox(height: 4),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        display,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 72,
                          fontWeight: FontWeight.w300,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ── Buttons — do not edit ──
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, bottom: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      calcButton(label: 'AC', bgColor: grayBtn, onTap: onClear),
                      calcButton(
                        label: '+/-',
                        bgColor: grayBtn,
                        onTap: onToggleSign,
                      ),
                      calcButton(
                        label: '%',
                        bgColor: grayBtn,
                        onTap: onPercent,
                      ),
                      calcButton(
                        label: '/',
                        bgColor: orange,
                        onTap: () => onOperator('/'),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      calcButton(
                        label: '7',
                        bgColor: darkBtn,
                        onTap: () => onNumber('7'),
                      ),
                      calcButton(
                        label: '8',
                        bgColor: darkBtn,
                        onTap: () => onNumber('8'),
                      ),
                      calcButton(
                        label: '9',
                        bgColor: darkBtn,
                        onTap: () => onNumber('9'),
                      ),
                      calcButton(
                        label: 'x',
                        bgColor: orange,
                        onTap: () => onOperator('x'),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      calcButton(
                        label: '4',
                        bgColor: darkBtn,
                        onTap: () => onNumber('4'),
                      ),
                      calcButton(
                        label: '5',
                        bgColor: darkBtn,
                        onTap: () => onNumber('5'),
                      ),
                      calcButton(
                        label: '6',
                        bgColor: darkBtn,
                        onTap: () => onNumber('6'),
                      ),
                      calcButton(
                        label: '-',
                        bgColor: orange,
                        onTap: () => onOperator('-'),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      calcButton(
                        label: '1',
                        bgColor: darkBtn,
                        onTap: () => onNumber('1'),
                      ),
                      calcButton(
                        label: '2',
                        bgColor: darkBtn,
                        onTap: () => onNumber('2'),
                      ),
                      calcButton(
                        label: '3',
                        bgColor: darkBtn,
                        onTap: () => onNumber('3'),
                      ),
                      calcButton(
                        label: '+',
                        bgColor: orange,
                        onTap: () => onOperator('+'),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      calcButton(
                        label: '⌫',
                        bgColor: darkBtn,
                        onTap: onBackspace,
                      ),
                      calcButton(
                        label: '0',
                        bgColor: darkBtn,
                        onTap: () => onNumber('0'),
                      ),
                      calcButton(
                        label: '.',
                        bgColor: darkBtn,
                        onTap: onDecimal,
                      ),
                      calcButton(label: '=', bgColor: orange, onTap: onEquals),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}