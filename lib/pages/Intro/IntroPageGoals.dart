import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muhnee/pages/Home/ExpensePageSingleFile.dart';
import '../../utilities/FadeRoute.dart';
import 'package:muhnee/utilities/ShowUp.dart';
import 'package:muhnee/utilities/FirestoreFunctions.dart';
import '../Home/HomePage.dart';
import 'package:muhnee/utilities/SizeConfig.dart';

var amount = "0";

class IntroPageGoals extends StatefulWidget {
  @override
  _IntroPageGoalsState createState() => _IntroPageGoalsState();
}

class _IntroPageGoalsState extends State<IntroPageGoals> {
  int delayAmount = 500;
  var goalAmount = "0";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: ListView(
        children: <Widget>[
          ShowUpText(),
          SizedBox(height: SizeConfig.blockSizeVertical * 1.5),
          ShowUp(
            child: AmountText(),
            delay: delayAmount * 6,
          ),
          CustomKeyboard(),
          SizedBox(height: SizeConfig.blockSizeVertical * 1.5),
          NextButton(),
        ],
      ),
    );
  }

  Widget ShowUpText() {
    return Padding(
      padding: EdgeInsets.only(top: 54.0, left: 22.0, right: 22.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ShowUp(
            child: Padding(
              padding: EdgeInsets.only(bottom: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Finally, ",
                      style: TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      )),
                  Text("how much",
                      style: TextStyle(
                        fontSize: 28.0,
                        color: Colors.black,
                      )),
                ],
              ),
            ),
            delay: delayAmount,
          ),
          ShowUpLineText("would you like", delayAmount * 2),
          ShowUpLineText("to save every week?", delayAmount * 4),
        ],
      ),
    );
  }

  Widget ShowUpLineText(lineText, delayAmountSpecific) {
    return ShowUp(
      child: Padding(
        padding: EdgeInsets.only(bottom: 15.0),
        child: Text(lineText,
            style: TextStyle(
              fontSize: 28.0,
              // fontFamily: "Montserrat",
              color: Colors.black,
            )),
      ),
      delay: delayAmountSpecific,
    );
  }

  Widget AmountText() {
    return Container(
      child: Center(
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            Text("\$ ",
                style: TextStyle(
                    fontSize: 45,
                    fontFamily: "SFPro",
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600])),
            Text(goalAmount.toString(),
                style: TextStyle(
                    fontSize: 80,
                    fontFamily: "SFPro",
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600])),
          ],
        ),
      ),
    );
  }

  Widget CustomKeyboard() {
    return SizedBox(
        height: SizeConfig.blockSizeVertical * 30,
        child: Container(
          //color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ShowUp(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    KeyboardCell("1"),
                    KeyboardCell("2"),
                    KeyboardCell("3"),
                  ],
                ),
                delay: delayAmount * 8,
              ),
              ShowUp(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    KeyboardCell("4"),
                    KeyboardCell("5"),
                    KeyboardCell("6"),
                  ],
                ),
                delay: delayAmount * 9,
              ),
              ShowUp(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    KeyboardCell("7"),
                    KeyboardCell("8"),
                    KeyboardCell("9"),
                  ],
                ),
                delay: delayAmount * 10,
              ),
              ShowUp(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.blockSizeVertical * 0.6,
                      ),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.grey[100],
                        elevation: 0,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: SizeConfig.blockSizeVertical * 1.8),
                          child: Icon(Icons.brightness_1,
                              size: 8, color: Colors.black),
                        ),
                        onPressed: () {
                          setState(() {
                            goalAmount += ".";
                            amount += ".";
                          });
                        },
                      ),
                    ),
                    KeyboardCell("0"),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.blockSizeVertical * 0.6,
                      ),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.grey[100],
                        elevation: 0,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: SizeConfig.blockSizeVertical * 0.95),
                          child: Icon(Icons.first_page, color: Colors.black),
                        ),
                        onPressed: () {
                          print("delete char");

                          if (goalAmount.length == 1) {
                            setState(() {
                              goalAmount = "0";
                              amount = "0";
                            });
                          } else {
                            setState(() {
                              goalAmount = goalAmount.substring(
                                  0, (goalAmount.length - 1));

                              amount = goalAmount.substring(
                                  0, (goalAmount.length - 1));
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
                delay: delayAmount * 12,
              ),
            ],
          ),
        ));
  }

  Widget KeyboardCell(cellValue) {
    return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.blockSizeVertical * 0.6,
        ),
        child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            //side: BorderSide(color: Colors.grey[200])
          ),
          color: Colors.grey[100],
          elevation: 0,
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: SizeConfig.blockSizeVertical * 1,
            ),
            child: Text(
              cellValue,
              textAlign: TextAlign.center,
              style: GoogleFonts.kulimPark(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                textStyle: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ),
          onPressed: () {
            goalAmount == "0"
                ? setState(() {
                    goalAmount = cellValue;
                    amount = cellValue;
                  })
                : setState(() {
                    goalAmount += cellValue;
                    amount += cellValue;
                  });
          },
        ));
  }
}

class NextButton extends StatefulWidget {
  @override
  _NextButtonState createState() => _NextButtonState();
}

class _NextButtonState extends State<NextButton> {
  @override
  Widget build(BuildContext context) {
    //! does this go within or ouside of the build method???
    var delayAmount = 500;

    return ShowUp(
      child: Padding(
          padding: EdgeInsets.only(bottom: 142.0),
          child: Center(
            child: SizedBox(
              width: 150,
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(23.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          blurRadius: 40.0,
                        ),
                      ]),
                  child: Material(
                    borderRadius: BorderRadius.circular(23.0),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(23.0),
                      onTap: () {
                        uploadGoals(int.parse(amount));

                        print(amount);

                        setOnboardedParam();

                        Navigator.pushReplacement(
                            context, FadeRouteBuilder(page: HomePage()));
                      },
                      child: Padding(
                        padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Next",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
            ),
          )),
      delay: delayAmount * 10,
    );
  }
}
