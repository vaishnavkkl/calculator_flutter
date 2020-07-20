import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(primarySwatch: Colors.grey, primaryColor: Colors.black),
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String equation = "";
  String result = "";
  String expression = "";
  double equationFontSize = 38;
  double resultFontSize = 48;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equation = "0";
        result = "0";
        equationFontSize = 38;
        resultFontSize = 48;
      } else if (buttonText == "clear") {
        equation = equation.substring(0, equation.length - 1);
        equationFontSize = 48;
        resultFontSize = 38;
        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "=") {
        expression = equation;
        equationFontSize = 38;
        resultFontSize = 48;
        try {
          Parser p = new Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "error";
        }
      } else {
        equationFontSize = 48;
        resultFontSize = 38;
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
        color: buttonColor,
        child: FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
              side: BorderSide(
                  color: Colors.blueGrey, width: 1, style: BorderStyle.solid)),
          padding: EdgeInsets.all(15.0),
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.normal,
                color: Colors.white),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Calculator',
          textAlign: TextAlign.end,
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(
                10,
                20,
                10,
                0,
              ),
              child: Text(
                equation,
                style:
                    TextStyle(fontSize: equationFontSize, color: Colors.white),
              )),
          Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(
                10,
                20,
                10,
                0,
              ),
              child: Text(
                result,
                style: TextStyle(fontSize: resultFontSize, color: Colors.white),
              )),
          Expanded(child: Divider()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.75,
                child: Table(children: [
                  TableRow(children: [
                    buildButton("C", 1, Colors.red[200]),
                    buildButton("clear", 1, Colors.blueGrey[900]),
                    buildButton("/", 1, Colors.blueGrey[900])
                  ]),
                  TableRow(children: [
                    buildButton("7", 1, Colors.blueGrey[900]),
                    buildButton("8", 1, Colors.blueGrey[900]),
                    buildButton("9", 1, Colors.blueGrey[900])
                  ]),
                  TableRow(children: [
                    buildButton("4", 1, Colors.blueGrey[900]),
                    buildButton("5", 1, Colors.blueGrey[900]),
                    buildButton("6", 1, Colors.blueGrey[900])
                  ]),
                  TableRow(children: [
                    buildButton("1", 1, Colors.blueGrey[900]),
                    buildButton("2", 1, Colors.blueGrey[900]),
                    buildButton("3", 1, Colors.blueGrey[900])
                  ]),
                  TableRow(children: [
                    buildButton(".", 1, Colors.blueGrey[900]),
                    buildButton("0", 1, Colors.blueGrey[900]),
                    buildButton("00", 1, Colors.blueGrey[900])
                  ])
                ]),
              ),
              Container(
                  width: MediaQuery.of(context).size.width * .25,
                  child: Table(
                    children: [
                      TableRow(children: [
                        buildButton("*", 1, Colors.lightBlue[900]),
                      ]),
                      TableRow(children: [
                        buildButton("+", 1, Colors.lightBlue[900]),
                      ]),
                      TableRow(children: [
                        buildButton("-", 1, Colors.lightBlue[900]),
                      ]),
                      TableRow(
                          children: [buildButton("=", 2, Colors.teal[800])])
                    ],
                  ))
            ],
          )
        ],
      ),
    );
  }
}
