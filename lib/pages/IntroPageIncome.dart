import 'package:flutter/material.dart';
import 'package:muhnee_app/pages/HomePage.dart';
import 'package:muhnee_app/routing/FadeRoute.dart';
import 'package:muhnee_app/utilities/ShowUp.dart';
import 'HomePage.dart';

class IntroPageIncome extends StatefulWidget {
  @override
  _IntroPageIncomeState createState() => _IntroPageIncomeState();
}

class _IntroPageIncomeState extends State<IntroPageIncome> {
  int delayAmount = 500;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ShowUpText(),
          ExpCellsComponent(delayAmount: delayAmount),
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
                  Text("Now, ",
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      )),
                  Text("what are your",
                      style: TextStyle(
                        fontSize: 30.0,
                        color: Colors.black,
                      )),
                ],
              ),
            ),
            delay: delayAmount,
          ),
          ShowUpLineText("sources of income?", delayAmount * 2),
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
              fontSize: 30.0,
              // fontFamily: "Montserrat",
              color: Colors.black,
            )),
      ),
      delay: delayAmountSpecific,
    );
  }
}

class ExpCellsComponent extends StatelessWidget {
  var delayAmount;
  ExpCellsComponent({this.delayAmount});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 52.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SingleExpCell(
            incomeType: "Work",
          ),
          SingleExpCell(
            incomeType: "Hobbies",
          ),
          SingleExpCell(
            incomeType: "Side Hustle",
          ),

          //Row 4 = Custom input row

          ShowUp(
            child: Padding(
              padding: EdgeInsets.only(bottom: 25, top: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 250,
                    height: 40,
                    child: Padding(
                      padding:
                          EdgeInsets.only(left: 20.0, right: 20.0, bottom: 2.0),
                      child: TextField(
                        style: TextStyle(fontSize: 15.0, color: Colors.black),
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: 'Custom...'),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xffDEDEDE),
                      borderRadius: BorderRadius.circular(13.0),
                    ),
                  ),

                  TickBtnIncome(),
                 
                ],
              ),
            ),
            delay: delayAmount * 9,
          )
        ],
      ),
    );
  }
}


class TickBtnIncome extends StatefulWidget {
  @override
  _TickBtnIncomeState createState() => _TickBtnIncomeState();
}

class _TickBtnIncomeState extends State<TickBtnIncome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 40.0,
          )
        ],
        borderRadius: BorderRadius.circular(13.0),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(13.0),
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Image(
              image: AssetImage("lib/assets/images/tick.png"),
            ),
          ),
          onTap: () {
            Scaffold.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.white,
              elevation: 0,
              content: Text(
                'added',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color(0xff8e91f3),
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              ),
            ));

            print("Income type added");
          },
        ),
      ),
    );
  }
}

class SingleExpCell extends StatefulWidget {
  var incomeType;
  //var width;
  var testArray = [];
  SingleExpCell({
    @required this.incomeType,
  });

  @override
  _SingleExpCellState createState() => _SingleExpCellState();
}

class _SingleExpCellState extends State<SingleExpCell> {
  //! should this be in the build or not???
  var cellColor = Color(0xffDEDEDE).withOpacity(0.75);
  var textColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.0),
      child: GestureDetector(
          child: AnimatedContainer(
            duration: Duration(milliseconds: 400),

            //TODO: make this dynamic
            width: 110,
            height: 34,
            child: Center(
              child: Text(
                widget.incomeType,
                style: TextStyle(
                    fontSize: 15.0,
                    color: textColor,
                    fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
            ),
            decoration: BoxDecoration(
              color: cellColor,
              borderRadius: BorderRadius.circular(50.0),
            ),
          ),
          onTap: () {
            //set the state of itself
            //if cell colour is grey set it to purple and update the array
            if (cellColor == Color(0xffDEDEDE)) {
              setState(() {
                cellColor = Color(0xff8e91f3).withOpacity(0.75);
                textColor = Colors.white;

                //add to array
                widget.testArray.add(widget.incomeType);
                print(widget.testArray);
              });
            }
            //else if its purple, set colour back to grey and remove from array
            else {
              setState(() {
                cellColor = Color(0xffDEDEDE);
                textColor = Colors.black;

                //remove from array
                widget.testArray.remove(widget.incomeType);
                print(widget.testArray);
              });
            }
          }),
    );
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
                        Navigator.pushReplacement(
                            context, FadeRouteBuilder(page: HomePage(userName: "TEST",)));
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
