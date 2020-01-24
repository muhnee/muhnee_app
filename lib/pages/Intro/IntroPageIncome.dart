import 'package:flutter/material.dart';
import '../../utilities/FadeRoute.dart';
import 'package:muhnee/utilities/ShowUp.dart';
import 'package:muhnee/utilities/FirestoreFunctions.dart';
import '../Home/HomePage.dart';
import 'package:muhnee/utilities/SizeConfig.dart';

var incomes = [];

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
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: ListView(
        children: <Widget>[
          ShowUpText(),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 6,
          ),
          IncCellsComponent(),
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
          ShowUpLineText("sources of income?", delayAmount * 3),
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

addToIncomes(incomeType) {
  incomes.add(incomeType);
}

removeFromIncomes(incomeType) {
  incomes.remove(incomeType);
}

class IncCellsComponent extends StatefulWidget {
  @override
  _IncCellsComponentState createState() => _IncCellsComponentState();
}

class _IncCellsComponentState extends State<IncCellsComponent> {
  var delayAmount = 500;

  final customIncomeController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    customIncomeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 52.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ShowUp(
            child: SingleExpCell(
              incomeType: "Work",
            ),
            delay: delayAmount * 5,
          ),

          ShowUp(
            child: SingleExpCell(
              incomeType: "Hobbies",
            ),
            delay: delayAmount * 6,
          ),

          ShowUp(
            child: SingleExpCell(
              incomeType: "Side Hustle",
            ),
            delay: delayAmount * 7,
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
                        controller: customIncomeController,
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
                  TickBtnIncome(customIncomeController: customIncomeController),
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
  var customIncomeController;

  TickBtnIncome({@required this.customIncomeController});

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

            if (widget.customIncomeController.text.isNotEmpty) {
              

              var customIncome = widget.customIncomeController.text;
              addToIncomes(customIncome);


              Scaffold.of(context).showSnackBar(SnackBar(
                //behavior: SnackBarBehavior.floating,
                //elevation: 0,
                //           shape: RoundedRectangleBorder(
                //   borderRadius: BorderRadius.circular(10.0),
                // ),
                // duration: Duration(seconds: 1),
                backgroundColor: Colors.grey[300],
                content: Text(
                  customIncome + " added",
                  style: TextStyle(color: Colors.black),
                ),
                action: SnackBarAction(
                  label: 'Undo',
                  textColor: Colors.black,
                  onPressed: () {
                    removeFromIncomes(customIncome);
                  },
                ),
              ));

              widget.customIncomeController.clear();

              print(incomes);
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
  var incomeType;

  SingleExpCell({
    @required this.incomeType,
  });

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
        widget.incomeType,
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
          addToIncomes(widget.incomeType);
        }
        //else if its purple, set colour back to grey and remove from array
        else {
          setState(() {
            cellColor = Colors.grey[300];
            textColor = Colors.black;
          });

          //remove from array
          removeFromIncomes(widget.incomeType);
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
                        incomes.add("Other");
                        uploadIncomes(incomes);
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
