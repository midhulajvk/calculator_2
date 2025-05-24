import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculatorscreen extends StatefulWidget {
  const Calculatorscreen({super.key});

  @override
  State<Calculatorscreen> createState() => _CalculatorscreenState();
}

class _CalculatorscreenState extends State<Calculatorscreen> {
  String input = "";
  String output = "0";

  Widget button(String text, {bool isRightColumn = false}) {
    return Expanded(

      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SizedBox(
         
          width: 15,
          height: 55,
          child: ElevatedButton(
            onPressed: () {
              buttonpressed(text);
            },
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: text == "="
                  ? const Color.fromRGBO(251, 255, 43, 1)
                  : isRightColumn
                      ? Colors.yellow
                      : Colors.white,
              foregroundColor: text == "="
                  ? Colors.white
                  : isRightColumn
                      ? const Color.fromARGB(255, 251, 250, 250)
                      : Colors.black,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
            ),
          ),
        ),
      ),
    );
  }

  void buttonpressed(String value) {
    setState(() {
      if (value == "C") {
        input = "";
        output = "0";
      } else if (value == "DEL") {
        if (input.isNotEmpty) {
          input = input.substring(0, input.length - 1);
        }
      } else if (value == "=") {
        try {
          output = evaluateexpression(input);
        } catch (e) {
          output = "error";
        }
      } else if (value == ",") {
        input += ".";
      } else if (value == "%") {
        if (input.isNotEmpty) {
          int i = input.length - 1;
          while (i >= 0 && RegExp(r'[0-9.]').hasMatch(input[i])) {
            i--;
          }
          String number = input.substring(i + 1);
          String before = input.substring(0, i + 1);

          try {
            double percent = double.parse(number) / 100;
            input = before + percent.toString();
          } catch (e) {
            output = "error";
          }
        }
      } else if (value == "+/-") {
        if (input.isNotEmpty) {
          int i = input.length - 1;
          while (i >= 0 && RegExp(r'[0-9.]').hasMatch(input[i])) {
            i--;
          }
          String number = input.substring(i + 1);
          String before = input.substring(0, i + 1);

          if (number.startsWith("-")) {
            number = number.substring(1);
          } else {
            number = "-$number";
          }
          input = before + number;
        }
      } else {
        input += value;
      }
    });
  }

  String evaluateexpression(String expression) {
    try {
      return _calculate(expression).toString();
    } catch (e) {
      return "error";
    }
  }

  double _calculate(String expression) {
    expression = expression.replaceAll("x", "*").replaceAll("÷", "/");
    Parser p = Parser();
    Expression exp = p.parse(expression);
    ContextModel cm = ContextModel();
    return exp.evaluate(EvaluationType.REAL, cm);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 24, 24, 24),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(24),
                alignment: Alignment.bottomRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      input,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      output,
                      style: const TextStyle(
                        color: Colors.yellow,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                Row(
                  children: [
                    button("C"),
                    button("%"),
                    button("DEL"),
                    button("/", isRightColumn: true),
                  ],
                ),
                Row(
                  children: [
                    button("7"),
                    button("8"),
                    button("9"),
                    button("x", isRightColumn: true),
                  ],
                ),
                Row(
                  children: [
                    button("4"),
                    button("5"),
                    button("6"),
                    button("-", isRightColumn: true),
                  ],
                ),
                Row(
                  children: [
                    button("1"),
                    button("2"),
                    button("3"),
                    button("+", isRightColumn: true),
                  ],
                ),
                Row(
                  children: [
                    button("+/-"),
                    button("0"),
                    button(",",),
                    button("=", isRightColumn: true),
                  ],
                ),
              ],
            ),
          ],
        ),
     ),
   );
 }
}