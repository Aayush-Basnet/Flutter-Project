import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(MaterialApp(
      title: "Simple Calculator",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: homepage(),
    ));

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  String equation = " ";
  String result = " ";
  String expression = " ";
  double equationFontSize = 38;
  double resultFontSize = 48;
  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equation = " ";
        result = " ";
        equationFontSize = 38;
        resultFontSize = 48;
      } else if (buttonText == "DEL") {
        equationFontSize = 38;
        resultFontSize = 48;
        equation = equation.substring(0, equation.length - 1);
        if (equation == " ") {
          equation = "0";
        }
      } else if (buttonText == "=") {
        equationFontSize = 38;
        resultFontSize = 48;
        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');
        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "error";
        }
      } else {
        equationFontSize = 38;
        resultFontSize = 48;
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildbutton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: MaterialButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(1),
            side: BorderSide(
                color: Colors.white, width: 1, style: BorderStyle.solid)),
        padding: EdgeInsets.all(0),
        onPressed: () => buttonPressed(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.normal, color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Simple Calculator"),
        //centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
            child: Text(
              equation,
              style: TextStyle(fontSize: equationFontSize),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
            child: Text(
              result,
              style: TextStyle(fontSize: resultFontSize),
            ),
          ),
          Expanded(
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildbutton("C", 1, Colors.redAccent),
                      buildbutton("%", 1, Colors.blue),
                      buildbutton("÷", 1, Colors.blue),
                    ]),
                    TableRow(children: [
                      buildbutton("7", 1, Colors.black54),
                      buildbutton("8", 1, Colors.black54),
                      buildbutton("9", 1, Colors.black54),
                    ]),
                    TableRow(children: [
                      buildbutton("4", 1, Colors.black54),
                      buildbutton("5", 1, Colors.black54),
                      buildbutton("6", 1, Colors.black54),
                    ]),
                    TableRow(children: [
                      buildbutton("1", 1, Colors.black54),
                      buildbutton("2", 1, Colors.black54),
                      buildbutton("3", 1, Colors.black54),
                    ]),
                    TableRow(children: [
                      buildbutton(".", 1, Colors.black54),
                      buildbutton("0", 1, Colors.black54),
                      buildbutton("00", 1, Colors.black54),
                    ]),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildbutton("DEL", 1, Color.fromARGB(255, 230, 72, 15)),
                    ]),
                    TableRow(children: [
                      buildbutton("×", 1, Colors.blue),
                    ]),
                    TableRow(children: [
                      buildbutton("-", 1, Colors.blue),
                    ]),
                    TableRow(children: [
                      buildbutton("+", 1, Colors.blue),
                    ]),
                    TableRow(children: [
                      buildbutton("=", 1, Colors.redAccent),
                    ]),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
