import 'package:flutter/material.dart';
import 'package:muhnee/utilities/SizeConfig.dart';
import 'package:google_fonts/google_fonts.dart';

Color componentColor = Colors.black;
Color pageColor = Colors.white;

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
            InteractionPane(),
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
                        borderRadius: new BorderRadius.circular(10.0),
                        side: BorderSide(color: Colors.grey[200])),
                    color: Colors.grey[100],
                    elevation: 0,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: SizeConfig.blockSizeVertical * 1),
                      child: Icon(Icons.brightness_1,
                          size: 8, color: componentColor),
                    ),
                    onPressed: () {
                      setState(() {
                        amount += ".";
                      });
                    },
                  ),
                  KeyboardCell("0"),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        side: BorderSide(color: Colors.grey[200])),
                    color: Colors.grey[100],
                    elevation: 0,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: SizeConfig.blockSizeVertical * 1),
                      child: Icon(Icons.first_page, color: componentColor),
                    ),
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
          borderRadius: new BorderRadius.circular(10.0),
          side: BorderSide(color: Colors.grey[200])),
      color: Colors.grey[100],
      elevation: 0,
      child: Padding(
        padding:
            EdgeInsets.symmetric(vertical: SizeConfig.blockSizeVertical * 1),
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
      ),
      onPressed: () {
        setState(() {
          amount += cellValue;
        });
      },
    );
  }

  Widget InteractionPane() {
    var btn1 = {
      "startText": "Income",
      "width": 18,
      "startTextColor": Colors.black,
      "startCellColor": Color(0xffa2d56f).withOpacity(0.2),
      "endText": "Income",
      "endTextColor": Colors.black,
      "endCellColor": Color(0xfffddaea),
    };

    return SizedBox(
        width: SizeConfig.blockSizeHorizontal * 80,
        height: SizeConfig.blockSizeVertical * 20,
        child: Container(
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              // ROW FOR CATEGORY OPTIONS

              // ROW FOR BUTTONS

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

  SelectorButtonSingle({
    @required this.startText,
    @required this.width,
    @required this.startTextColor,
    @required this.startCellColor,
    @required this.endText,
    @required this.endTextColor,
    @required this.endCellColor,
  });

  @override
  _SelectorButtonSingleState createState() => _SelectorButtonSingleState();
}

class _SelectorButtonSingleState extends State<SelectorButtonSingle> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.blockSizeHorizontal * widget.width,
      height: SizeConfig.blockSizeVertical * 4,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: widget.startCellColor.withOpacity(0.25),
              blurRadius: 10.0,
            )
          ],
        ),
        child: Material(
          color: widget.startCellColor,
          borderRadius: BorderRadius.circular(10.0),
          child: InkWell(
            borderRadius: BorderRadius.circular(10.0),
            child: Center(
              child: Text(
                widget.startText,
                style: TextStyle(
                    color: widget.startTextColor,
                    letterSpacing: 1,
                    fontSize: 12.5,
                    fontWeight: FontWeight.bold),
              ),
            ),
            onTap: () {
              setState(() {
                widget.startText = widget.endText;
                widget.startTextColor = widget.endTextColor;
                widget.startCellColor = widget.endCellColor;
              });
            },
          ),
        ),
      ),
    );
  }
}
