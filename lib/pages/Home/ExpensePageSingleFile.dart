import 'package:flutter/material.dart';
import 'package:muhnee/utilities/FirestoreFunctions.dart';
import 'package:muhnee/utilities/SizeConfig.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

Color componentColor = Colors.black;
Color pageColor = Colors.white;

var expenseCategories = [
  "Food",
  "Clothing",
  "Tech",
  "Activities",
  "Coffee",
  "Alcohol"
];
var incomeCategories = ["Work"];

//to send
var amount = "0";
var transactionType = "Income";
var selectedCategories = [];
var isTaxable = false;

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
        height: SizeConfig.blockSizeVertical * 30,
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

                      if (amount.length == 1) {
                        setState(() {
                          amount = "0";
                        });
                      } else {
                        setState(() {
                          amount = amount.substring(0, (amount.length - 1));
                        });
                      }
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
        amount == "0"
            ? setState(() {
                amount = cellValue;
              })
            : setState(() {
                amount += cellValue;
              });
      },
    );
  }
}

class InteractionPane extends StatefulWidget {
  @override
  _InteractionPaneState createState() => _InteractionPaneState();
}

class _InteractionPaneState extends State<InteractionPane> {
  var incomeExpenseText = "Income";
  Color incomeExpenseColor = Color(0xffa5d15b);

  Color taxableColor = Colors.grey[300];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: SizeConfig.blockSizeHorizontal * 80,
        height: SizeConfig.blockSizeVertical * 14,
        child: Container(
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              // ROW FOR BUTTONS

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  // Income / Expense Button
                  RaisedButton(
                    child: Text(
                      incomeExpenseText,
                      style: TextStyle(color: Colors.white),
                    ),
                    color: incomeExpenseColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      //side: BorderSide(color: Colors.grey[200])
                    ),
                    elevation: 0,
                    onPressed: () {
                      if (incomeExpenseText == "Income") {
                        setState(() {
                          incomeExpenseText = "Expense";
                          transactionType = "Expense";
                          incomeExpenseColor = Color(0xfffb3d4e);
                          selectedCategories.clear();
                        });
                      } else {
                        setState(() {
                          incomeExpenseText = "Income";
                          transactionType = "Income";
                          incomeExpenseColor = Color(0xffa5d15b);
                          selectedCategories.clear();
                        });
                      }
                    },
                  ),

                  //Taxable Button
                  RaisedButton(
                    child: Text(
                      "Taxable",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: taxableColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      //side: BorderSide(color: Colors.grey[200])
                    ),
                    elevation: 0,
                    onPressed: () {
                      if (taxableColor == Colors.grey[300]) {
                        setState(() {
                          taxableColor = Color(0xff8e91f3);
                          isTaxable = true;
                          print(isTaxable);
                        });
                      } else {
                        setState(() {
                          taxableColor = Colors.grey[300];
                          isTaxable = false;
                          print(isTaxable);
                        });
                      }
                    },
                  ),

                  //Upload Button
                  RaisedButton(
                    child: Text(
                      "Upload",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Color(0xff1ea6f9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      //side: BorderSide(color: Colors.grey[200])
                    ),
                    elevation: 0,
                    onPressed: () {
                      //send to cloud

                      //should check if there is a failure or sucess

                      if (amount != "0") {
                        AwesomeDialog(
                                context: context,
                                dialogType: DialogType.SUCCES,
                                animType: AnimType.BOTTOMSLIDE,
                                tittle: transactionType + " uploaded",
                                desc: '\$' + amount,
                                btnOkOnPress: () {})
                            .show();

                        resetValues();
                      } else {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.ERROR,
                          animType: AnimType.BOTTOMSLIDE,
                          tittle: "Value empty",
                          desc: 'Add a transaction value',
                          btnCancelText: "Ok",
                          btnCancelOnPress: () {},
                        ).show();
                      }
                    },
                  ),
                ],
              ),

              // ROW FOR CATEGORY OPTIONS

              transactionType == "Income"
                  ? incomeCategorySection()
                  : expenseCategorySection(),
            ],
          ),
        ));
  }

  //TODO : setState on amount wont rebuild the view if in this widget

  resetValues() {
    setState(() {
      amount = "0";
      transactionType = "Income";
      selectedCategories = [];
      isTaxable = false;
    });

    print(amount);
    print(transactionType);
    print(selectedCategories);
    print(isTaxable);
  }
}

class expenseCategorySection extends StatefulWidget {
  expenseCategorySection({Key key}) : super(key: key);

  @override
  _expenseCategorySectionState createState() => _expenseCategorySectionState();
}

class _expenseCategorySectionState extends State<expenseCategorySection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.blockSizeVertical * 4.2,
      child: Center(
        child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: [
              for (var item in expenseCategories)
                CategorySelectorBtn(
                  catItem: item,
                )
            ]),
      ),

      // ListView(
      //   scrollDirection: Axis.horizontal,
      //   children: <Widget>[
      //     for (var item in expenseCategories)
      //       CategorySelectorBtn(
      //         catItem: item,
      //       )
      //   ],
      // ),
    );
  }
}

class incomeCategorySection extends StatefulWidget {
  incomeCategorySection({Key key}) : super(key: key);

  @override
  _incomeCategorySectionState createState() => _incomeCategorySectionState();
}

class _incomeCategorySectionState extends State<incomeCategorySection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.blockSizeVertical * 4.2, //! this is dumb
      child: Center(
        child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: [
              for (var item in incomeCategories)
                CategorySelectorBtn(
                  catItem: item,
                )
            ]),
      ),

      //  ListView(
      //   scrollDirection: Axis.horizontal,
      //   children: <Widget>[
      //     for (var item in incomeCategories)
      //       CategorySelectorBtn(
      //         catItem: item,
      //       )
      //   ],
      // ),
    );
  }
}

class CategorySelectorBtn extends StatefulWidget {
  var catItem;
  CategorySelectorBtn({@required this.catItem});

  @override
  _CategorySelectorBtnState createState() => _CategorySelectorBtnState();
}

class _CategorySelectorBtnState extends State<CategorySelectorBtn> {
  Color unselectedBtnColor = Colors.grey[300];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.0),
      child: RaisedButton(
        child: Text(
          widget.catItem,
          style: TextStyle(color: Colors.white),
        ),
        color: unselectedBtnColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 0,
        onPressed: () {
          if (unselectedBtnColor == Colors.grey[300]) {
            setState(() {
              unselectedBtnColor = Color(0xff8e91f3);
              selectedCategories.add(widget.catItem);
              print(selectedCategories);
            });
          } else {
            setState(() {
              unselectedBtnColor = Colors.grey[300];
              selectedCategories.remove(widget.catItem);
              print(selectedCategories);
            });
          }
        },
      ),
    );
  }
}
