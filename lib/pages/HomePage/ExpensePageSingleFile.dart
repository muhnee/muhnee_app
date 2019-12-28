import 'package:flutter/material.dart';
import 'package:muhnee/routing/FadeRoute.dart';
import 'package:muhnee/utilities/FirestoreFunctions.dart';
import 'package:muhnee/utilities/SignIn.dart';
import 'package:muhnee/utilities/SizeConfig.dart';
import '../../main.dart';
import 'package:google_fonts/google_fonts.dart';

Color componentColor = Colors.black;
Color pageColor = Colors.grey[300];

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
                  GestureDetector(
                    child: SizedBox(
                      child: Icon(Icons.first_page, color: componentColor),
                      width: SizeConfig.blockSizeHorizontal * 15,
                    ),
                    onTap: () {
                      print("delete char");
                      setState(() {
                        amount = amount.substring(0, (amount.length - 1));
                      });
                    },
                  ),
                  KeyboardCell("0"),
                  GestureDetector(
                    child: SizedBox(
                      child: Icon(Icons.check_circle_outline,
                          size: 20, color: componentColor),
                      width: SizeConfig.blockSizeHorizontal * 15,
                    ),
                    onTap: () {
                      print("upload to firebase");
                    },
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  Widget KeyboardCell(cellValue) {
    return GestureDetector(
        child: SizedBox(
          width: SizeConfig.blockSizeHorizontal * 15,
          child: Center(
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
        ),
        onTap: () {
          setState(() {
            amount += cellValue;
          });
        });
  }
}
