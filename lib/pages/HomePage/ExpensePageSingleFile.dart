import 'package:flutter/material.dart';
import 'package:muhnee/pages/HomePage/LeftPanel.dart';
import 'package:muhnee/routing/FadeRoute.dart';
import 'package:muhnee/utilities/FirestoreFunctions.dart';
import 'package:muhnee/utilities/SignIn.dart';
import 'package:muhnee/utilities/SizeConfig.dart';
import '../../main.dart';
import 'package:google_fonts/google_fonts.dart';

Color componentColor = Colors.black;
Color pageColor = Colors.grey[100];

var amount = "";

class ExpensePageSingleFile extends StatefulWidget {
  @override
  _ExpensePageSingleFileState createState() => _ExpensePageSingleFileState();
}

class _ExpensePageSingleFileState extends State<ExpensePageSingleFile> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: pageColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(amount,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: componentColor,
                )),
            SelectorButtons(),
            CustomKeyboard(),
          ],
        ),
      ),
    );
  }

  Widget CustomKeyboard() {
    return SizedBox(
        width: SizeConfig.blockSizeHorizontal * 80,
        height: SizeConfig.blockSizeVertical * 35,
        child: Container(
          color: pageColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  KeyboardCell("1"),
                  KeyboardCell("2"),
                  KeyboardCell("3"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  KeyboardCell("4"),
                  KeyboardCell("5"),
                  KeyboardCell("6"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  KeyboardCell("7"),
                  KeyboardCell("8"),
                  KeyboardCell("9"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(50.0),
                      // side: BorderSide(color: pageColor)
                    ),
                    color: pageColor,
                    elevation: 0,
                    child: Icon(Icons.brightness_1,
                        size: 8, color: componentColor),
                    onPressed: () {
                      setState(() {
                        amount += ".";
                      });
                    },
                  ),
                  KeyboardCell("0"),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(50.0),
                      // side: BorderSide(color: pageColor)
                    ),
                    color: pageColor,
                    elevation: 0,
                    child: Icon(Icons.first_page, color: componentColor),
                    onPressed: () {
                      print("delete char");
                      setState(() {
                        amount = amount.substring(0, (amount.length - 1));
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  Widget KeyboardCell(cellValue) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(50.0),
        // side: BorderSide(color: pageColor)
      ),
      color: pageColor,
      elevation: 0,
      child: Text(
        cellValue,
        textAlign: TextAlign.center,
        style: GoogleFonts.kulimPark(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          textStyle: TextStyle(
            color: componentColor,
          ),
        ),
      ),
      onPressed: () {
        setState(() {
          amount += cellValue;
        });
      },
    );
  }

  Widget SelectorButtons() {
    var btn1 = {
      "startText": "Expense",
      "width": 19,
      "startTextColor": Color(0xffa2d56f),
      "startCellColor": Color(0xffa2d56f).withOpacity(0.5),
      "endText": "Income",
      "endTextColor": Color(0xfff990bf),
      "endCellColor": Color(0xfffddaea),
    };

    var btn2 = {
      "startText": "Taxable",
      "width": 25,
      "startTextColor": Color(0xffa2d56f),
      "startCellColor": Color(0xffa2d56f).withOpacity(0.5),
      "endText": "Taxable",
      "endTextColor": Color(0xfff990bf),
      "endCellColor": Color(0xfffddaea),
    };

    var btn3 = {
      "startText": "Upload",
      "width": 19,
      "startTextColor": Color(0xffd4455b),
      "startCellColor": Color(0xfff6d9dd),
      "endText": "Upload",
      "endTextColor": Color(0xff4a5999),
      "endCellColor": Color(0xffd9dcea),
    };

    return SizedBox(
        width: SizeConfig.blockSizeHorizontal * 80,
        height: SizeConfig.blockSizeVertical * 5,
        child: Container(
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SelectorButtonSingle(
                    startText: btn1["startText"],
                    width: btn1["width"],
                    startTextColor: btn1["startTextColor"],
                    startCellColor: btn1["startCellColor"],
                    endText: btn1["endText"],
                    endTextColor: btn1["endTextColor"],
                    endCellColor: btn1["endCellColor"],
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}

class SelectorButtonSingle extends StatefulWidget {
  var startText;
  var width;
  var startTextColor;
  var startCellColor;
  var endText;
  var endTextColor;
  var endCellColor;

  SelectorButtonSingle(
      {@required this.startText,
      @required this.width,
      @required this.startTextColor,
      @required this.startCellColor,
      @required this.endText,
      @required this.endTextColor,
      @required this.endCellColor});

  @override
  _SelectorButtonSingleState createState() => _SelectorButtonSingleState();
}

class _SelectorButtonSingleState extends State<SelectorButtonSingle> {

  @override
  Widget build(BuildContext context) {

    var stateText = widget.startText;
    Color stateCellColor = widget.startCellColor; 
    Color stateTextColor = widget.startCellColor; 


    return SizedBox(
      width: SizeConfig.blockSizeHorizontal * widget.width,
      height: SizeConfig.blockSizeVertical * 4,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: stateTextColor.withOpacity(0.25),
              blurRadius: 10.0,
            )
          ],
        ),
        child: Material(
          color: stateCellColor,
          borderRadius: BorderRadius.circular(10.0),
          child: InkWell(
            borderRadius: BorderRadius.circular(10.0),
            child: Center(
              child: Text(
                stateText,
                style: TextStyle(
                    color: stateTextColor,
                    letterSpacing: 1,
                    fontSize: 12.5,
                    fontWeight: FontWeight.bold),
              ),
            ),
            onTap: () {

              // if (stateCellColor == widget.startCellColor ) {
                
              // }


             
            },
          ),
        ),
      ),
    );
  }
}
