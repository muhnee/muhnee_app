import 'package:flutter/material.dart';
import 'package:muhnee_app/routing/FadeRoute.dart';
import 'package:muhnee_app/utilities/ShowUp.dart';
import 'IntroPageIncome.dart';

class IntroPageExpense extends StatefulWidget {
  @override
  _IntroPageExpenseState createState() => _IntroPageExpenseState();
}

class _IntroPageExpenseState extends State<IntroPageExpense> {
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
          ExpCells(),
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
                  Text("Firstly, ",
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      )),
                  Text("let's add some",
                      style: TextStyle(
                        fontSize: 30.0,
                        color: Colors.black,
                      )),
                ],
              ),
            ),
            delay: delayAmount,
          ),
          ShowUpLineText("categories to group", delayAmount * 2),
          ShowUpLineText("your expenses", delayAmount * 4),
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

class ExpCells extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 52.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          //Row 1
          Padding(
            padding: EdgeInsets.only(bottom: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SingleExpCell(
                  expenseType: "Food",
                ),
                SingleExpCell(
                  expenseType: "Clothing",
                ),
                SingleExpCell(
                  expenseType: "Rent",
                ),
              ],
            ),
          ),

          //Row 2
          Padding(
            padding: EdgeInsets.only(bottom: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SingleExpCell(
                  expenseType: "Fuel",
                ),
                SingleExpCell(
                  expenseType: "Tech",
                ),
                SingleExpCell(
                  expenseType: "Drinks",
                ),
              ],
            ),
          ),

          //Row 3
          Padding(
            padding: EdgeInsets.only(bottom: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SingleExpCell(
                  expenseType: "Coffee",
                ),
                SingleExpCell(
                  expenseType: "Activities",
                ),
                SingleExpCell(
                  expenseType: "Alcohol",
                ),
              ],
            ),
          ),

          //Row 4
          Padding(
            padding: EdgeInsets.only(bottom: 25),
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
                Container(
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Image(
                      image: AssetImage("lib/assets/images/tick.png"),
                    ),
                  ),
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SingleExpCell extends StatelessWidget {
  var expenseType;
  var cellColor = Color(0xffDEDEDE);

  SingleExpCell({this.expenseType});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 91,
        height: 34,
        child: Center(
          child: Text(
            expenseType,
            style: TextStyle(
                fontSize: 15.0,
                color: Colors.black,
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
        itemSelected(expenseType, cellColor);
      },
    );
  }
}

void itemSelected(expenseType, cellColor) async {
  var selectedItems = [];

  if (selectedItems.contains(expenseType)) {
    //set colour to grey and remove the item
    selectedItems.remove(expenseType);

    // setState(() { });

    cellColor = Color(0xffDEDEDE);
  } else {
    selectedItems.add(expenseType);
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
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context, FadeRouteBuilder(page: IntroPageIncome()));
                },
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
                  child: Padding(
                    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Next",
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )),
      delay: delayAmount * 6,
    );
  }
}
