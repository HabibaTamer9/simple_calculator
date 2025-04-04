import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String input = "";
  String ans = "";
  String opr = "";
  String numone = "";
  String numtwo = "";
  double result = 0;

  List<String> buttons = [
    "C",
    "%",
    "D",
    "/",
    "7",
    "8",
    "9",
    "x",
    "4",
    "5",
    "6",
    "-",
    "1",
    "2",
    "3",
    "+",
    "00",
    "0",
    ".",
    "="
  ];
  List<int> colors = [
    0xFF252525,
    0xFF252525,
    0xFF252525,
    0xFF252525,
    0xFF0f0f0e,
    0xFF0f0f0e,
    0xFF0f0f0e,
    0xFF252525,
    0xFF0f0f0e,
    0xFF0f0f0e,
    0xFF0f0f0e,
    0xFF252525,
    0xFF0f0f0e,
    0xFF0f0f0e,
    0xFF0f0f0e,
    0xFF252525,
    0xFF0f0f0e,
    0xFF0f0f0e,
    0xFF0f0f0e,
    0xFFc13900
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(
            "Calculator",
            style: TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.black,
        ),
        body: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(20),
                alignment: Alignment.centerLeft,
                width: double.infinity,
                child: Text(
                  input,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.centerRight,
                  width: double.infinity,
                  child: Text(
                    ans,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )),
            Expanded(
                flex: 4,
                child: Container(
                    margin: EdgeInsets.all(15),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                        mainAxisExtent: 60,
                      ),
                      itemCount: buttons.length,
                      itemBuilder: (context, i) {
                        if (i == 0) {
                          return mybutton(buttons[i], colors[i], 0);
                        } else if (i == 2) {
                          return mybutton(buttons[i], colors[i], 1);
                        } else if (i == buttons.length - 1) {
                          return mybutton(buttons[i], colors[i], 2);
                        } else if (i == 1 ||
                            i == 3 ||
                            i == 7 ||
                            i == 11 ||
                            i == 15) {
                          return mybutton(buttons[i], colors[i], 3);
                        } else {
                          return mybutton(buttons[i], colors[i], 4);
                        }
                      },
                    )))
          ],
        ),
      ),
    );
  }

  Widget mybutton(String text, int color, int n) {
    MaterialButton button;
    if (n == 0) {
      button = MaterialButton(
        color: Color(color),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(80),
        ),
        onPressed: () {
          setState(() {
            input = "";
            ans = "";
            opr = "";
            numone = "";
            numtwo = "";
            result = 0;
          });
        },
        child: Text(
          text,
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
      );
    } else if (n == 1) {
      button = MaterialButton(
        color: Color(color),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(80),
        ),
        onPressed: () {
          setState(() {
            if (input.isNotEmpty) {
              input = input.substring(0, input.length - 1);
              while (input.isNotEmpty && "+-x/%".contains(input[input.length - 1])) {
                input = input.substring(0, input.length - 1);
              }
              if (input.isEmpty) {
                ans = "";
                opr = "";
                numone = "";
                numtwo = "";
                result = 0;
              } else {
                int lastOperatorIndex = -1;
                for (int i = 0; i < input.length; i++) {
                  if ("+-x/%".contains(input[i])) {
                    lastOperatorIndex = i;
                  }
                }

                if (lastOperatorIndex != -1) {
                  opr = input[lastOperatorIndex];
                  numone = input.substring(0, lastOperatorIndex);
                  numtwo = input.substring(lastOperatorIndex + 1);

                  if (numtwo.isNotEmpty) {
                    result = operation(numone, numtwo, opr);
                  } else {
                    result = 0;
                  }
                } else {
                  numone = input;
                  opr = "";
                  numtwo = "";
                  result = 0;
                }
              }
            }

            ans = result.toString();
          });
        },
        child: Text(
          text,
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
      );
    } else if (n == 2) {
      button = MaterialButton(
        color: Color(color),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(80),
        ),
        onPressed: () {
          setState(() {
            ans = result.toString();
          });
        },
        child: Text(
          text,
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
      );
    } else if (n == 3) {
      button = MaterialButton(
        color: Color(color),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(80),
        ),
        onPressed: () {
          setState(() {
            if (ans == "") {
              numone = input;
            } else {
              numone = ans;
            }
            input += text;
            opr = text;
          });
        },
        child: Text(
          text,
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
      );
    } else {
      button = MaterialButton(
        color: Color(color),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(80),
        ),
        onPressed: () {
          setState(() {
            input += text;
            if (opr != "") {
              int k = 0;
              for (int i = 0; i < input.length; i++) {
                if (input[i] == "+" ||
                    input[i] == "-" ||
                    input[i] == "x" ||
                    input[i] == "/" ||
                    input[i] == "%") {
                  k = i;
                }
              }
              numtwo = input.substring(k + 1, input.length);
              result = operation(numone, numtwo, opr);
              ans = result.toString();
            } else {
              if (ans == "") {
                numone = input;
              } else {
                numone = ans;
              }
            }
          });
        },
        child: Text(
          text,
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
      );
    }
    return button;
  }

  double operation(String numone, String numtwo, String operation) {
    double result = 0;
    double one = double.parse(numone);
    double two = double.parse(numtwo);
    switch (operation) {
      case "+":
        result = one + two;
        break;
      case "-":
        result = one - two;
        break;
      case "x":
        result = one * two;
        break;
      case "/":
        result = one / two;
        break;
      case "%":
        result = one % two;
        break;
    }
    return result;
  }
}
