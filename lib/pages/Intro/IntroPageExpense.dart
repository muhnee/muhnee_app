import 'package:flutter/material.dart';
import 'package:muhnee/utilities/FirestoreFunctions.dart';
import 'package:muhnee/utilities/ShowUp.dart';
import 'package:muhnee/utilities/SizeConfig.dart';
import 'IntroPageIncome.dart';
import '../../utilities/FadeRoute.dart';

var expenses = [];

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
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: ListView(
        children: <Widget>[
          ShowUpText(),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 6,
          ),
          ExpCellsComponent(),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 6,
          ),
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
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      )),
                  Text("let's add some",
                      style: TextStyle(
                        fontSize: 28.0,
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
              fontSize: 28.0,
              // fontFamily: "Montserrat",
              color: Colors.black,
            )),
      ),
      delay: delayAmountSpecific,
    );
  }
}

addToExpenses(expenseType) {
  expenses.add(expenseType);
}

removeFromExpenses(expenseType) {
  expenses.remove(expenseType);
}

class ExpCellsComponent extends StatefulWidget {
  @override
  _ExpCellsComponentState createState() => _ExpCellsComponentState();
}

class _ExpCellsComponentState extends State<ExpCellsComponent> {
  var delayAmount = 500;

  final customExpenseController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    customExpenseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 52.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ShowUp(
            child: ExpCellOrdRow("Food", "Clothing", "Rent"),
            delay: delayAmount * 6,
          ),
          ShowUp(
            child: ExpCellOrdRow("Fuel", "Tech", "Drinks"),
            delay: delayAmount * 7,
          ),
          ShowUp(
            child: ExpCellOrdRow("Coffee", "Activites", "Alcohol"),
            delay: delayAmount * 8,
          ),

          //Row 4 = Custom input row

          ShowUp(
            child: Padding(
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
                        controller: customExpenseController,
                        textCapitalization: TextCapitalization.words,
                        style: TextStyle(fontSize: 15.0, color: Colors.black),
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: 'Custom...'),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(13.0),
                    ),
                  ),
                  TickBtn(customExpenseController: customExpenseController),
                ],
              ),
            ),
            delay: delayAmount * 10,
          )
        ],
      ),
    );
  }

  Widget ExpCellOrdRow(type1, type2, type3) {
    return Padding(
      padding: EdgeInsets.only(bottom: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SingleExpCell(
            expenseType: type1,
          ),
          SingleExpCell(
            expenseType: type2,
          ),
          SingleExpCell(
            expenseType: type3,
          ),
        ],
      ),
    );
  }
}

class TickBtn extends StatefulWidget {
  var customExpenseController;

  TickBtn({@required this.customExpenseController});

  @override
  _TickBtnState createState() => _TickBtnState();
}

class _TickBtnState extends State<TickBtn> {
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
            // Scaffold.of(context).showSnackBar(SnackBar(
            //   backgroundColor: Colors.white,
            //   elevation: 0,
            //   content: Text(
            //     'added',
            //     textAlign: TextAlign.center,
            //     style: TextStyle(
            //         color: Color(0xff8e91f3),
            //         fontWeight: FontWeight.bold,
            //         fontSize: 12),
            //   ),
            // ));

            if (widget.customExpenseController.text.isNotEmpty) {
              var customExpense = widget.customExpenseController.text;

              addToExpenses(customExpense);

              Scaffold.of(context).showSnackBar(SnackBar(
                //behavior: SnackBarBehavior.floating,
                //elevation: 0,
                //           shape: RoundedRectangleBorder(
                //   borderRadius: BorderRadius.circular(10.0),
                // ),
                // duration: Duration(seconds: 1),
                backgroundColor: Colors.grey[300],
                content: Text(
                  customExpense + " added",
                  style: TextStyle(color: Colors.black),
                ),
                action: SnackBarAction(
                  label: 'Undo',
                  textColor: Colors.black,
                  onPressed: () {
                    removeFromExpenses(customExpense);
                  },
                ),
              ));

              widget.customExpenseController.clear();

              print(expenses);
            } else {
              print("custom is empty");
            }
          },
        ),
      ),
    );
  }
}

class SingleExpCell extends StatefulWidget {
  var expenseType;
  SingleExpCell({@required this.expenseType});

  @override
  _SingleExpCellState createState() => _SingleExpCellState();
}

class _SingleExpCellState extends State<SingleExpCell> {
  //! should this be in the build or not???

  var cellColor = Colors.grey[300];
  var textColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      elevation: 0,
      child: Text(
        widget.expenseType,
        style: TextStyle(
            fontSize: 15.0, color: textColor, fontWeight: FontWeight.w400),
        textAlign: TextAlign.center,
      ),
      color: cellColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.0),
      ),
      onPressed: () {
        //set the state of itself
        //if cell colour is grey set it to purple and update the array
        if (cellColor == Colors.grey[300]) {
          setState(() {
            cellColor = Color(0xff8e91f3).withOpacity(0.75);
            textColor = Colors.white;
          });

          //add to array
          addToExpenses(widget.expenseType);
        }
        //else if its purple, set colour back to grey and remove from array
        else {
          setState(() {
            cellColor = Colors.grey[300];
            textColor = Colors.black;
          });

          //remove from array
          removeFromExpenses(widget.expenseType);
        }
      },
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
                        expenses.add("Other");
                        uploadCategories("expense", expenses);

                        Navigator.pushReplacement(
                            context, FadeRouteBuilder(page: IntroPageIncome()));
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
      delay: delayAmount * 11,
    );
  }
}
