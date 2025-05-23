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
  
  Widget button(String text) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {buttonpressed(text);},
        child: Text(
          text,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: text == "=" ? Colors.black : Colors.white,
          foregroundColor: text == "=" ? Colors.white: Colors.black,
          shape: CircleBorder(),
        ),
      ),
    );
  }
  void buttonpressed(String value){setState(() {
  if(value=="C"){input=" ";output="0";}else if(value=="DEL"){input=input.isEmpty ? input.substring(0,input.length-1):""; 
  }else if (value=="="){try{output=evaluateexpression(input);}catch(e){output="error";}}else{input+=value;}
  });}

  String evaluateexpression(String expression){try{return _calculate(expression).toString();}catch(e){return "error";}}
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
      backgroundColor: const Color.fromARGB(255, 26, 25, 25),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Container(padding: EdgeInsets.all(24),
                alignment: Alignment.bottomRight,
                child: Column(mainAxisAlignment:MainAxisAlignment.end ,crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      input,
                      style: TextStyle(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      output,
                      style: TextStyle(
                        color: Colors.black,
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
                    button("/"),
                  ],
                ),
                Row(
                  children: [button("7"), button("8"), button("9"), button("x")],
                ),
                Row(children: [button("4"),
                    button("5"),
                    button("6"),
                    button("-"),],),
                Row(
                  children: [button("1"), button("2"), button("3"), button("+")],
                ),
                Row(children: [button("+/-"),
                    button("0"),
                    button("."),
                    button("="),],),
              ],
            ),
          ],
        ),
      ),
    );
  }
}