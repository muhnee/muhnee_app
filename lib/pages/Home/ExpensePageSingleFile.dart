import 'package:flutter/material.dart';
import 'package:muhnee/utilities/FirestoreFunctions.dart';
import 'package:muhnee/utilities/SizeConfig.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

// Pull from Firebase

var tExp;
var tInc;

// Send as transaction
var amount = "0";
var transactionType = "Income";
var selectedCategories = [];
var isTaxable = false;

final descriptionController = TextEditingController();

class ExpensePageSingleFile extends StatefulWidget {
  @override
  _ExpensePageSingleFileState createState() => _ExpensePageSingleFileState();
}

class _ExpensePageSingleFileState extends State<ExpensePageSingleFile> {
  @override
  void initState() {
    super.initState();
    tExp = getExpenseCategories();
    tInc = getIncomeCategories();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      // backgroundColor: Colors.white,
      decoration: BoxDecoration(
          gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.grey[100], Colors.white],
              ),
        
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            AmountText(),
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
          //color: Colors.white,
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
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(color: Colors.grey[200])),
                    color: Colors.grey[100],
                    elevation: 0,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: SizeConfig.blockSizeVertical * 1),
                      child: Icon(Icons.brightness_1,
                          size: 8, color: Colors.black),
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
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(color: Colors.grey[200])),
                    color: Colors.grey[100],
                    elevation: 0,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: SizeConfig.blockSizeVertical * 1),
                      child: Icon(Icons.first_page, color: Colors.black),
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
          borderRadius: BorderRadius.circular(10.0),
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
              color: Colors.black,
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

  Widget AmountText() {
    return Container(
      child: Expanded(
        child: Center(
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: <Widget>[
              Text(
                "\$ ",
                style: GoogleFonts.varelaRound(
                  textStyle: TextStyle(fontSize: 35),
                ),
              ),
              Text(
                amount,
                style: GoogleFonts.varelaRound(
                  textStyle: TextStyle(fontSize: 80),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InteractionPane extends StatefulWidget {
  @override
  _InteractionPaneState createState() => _InteractionPaneState();
}

class _InteractionPaneState extends State<InteractionPane> {
  Color incomeExpenseColor = Color(0xffa5d15b);

  Color taxableColor = Colors.grey[300];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: SizeConfig.blockSizeHorizontal * 80,
        height: SizeConfig.blockSizeVertical * 17,
        child: Container(
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              // ROW FOR BUTTONS

              // ExpenseDescription(),

              transactionType == "Income"
                  ? ExpenseDescriptionEmptySpace()
                  : ExpenseDescription(),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  // Income / Expense Button
                  RaisedButton(
                    child: Text(
                      transactionType,
                      style: TextStyle(color: Colors.white),
                    ),
                    color: incomeExpenseColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      //side: BorderSide(color: Colors.grey[200])
                    ),
                    elevation: 0,
                    onPressed: () {
                      if (transactionType == "Income") {
                        setState(() {
                          transactionType = "Expense";
                          incomeExpenseColor = Color(0xfffb3d4e);
                          selectedCategories.clear();
                        });
                      } else {
                        setState(() {
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

                      if (amount != "0" && selectedCategories.isNotEmpty) {
                        var description;

                        transactionType == "Income"
                            ? description = ""
                            : descriptionController.text.isNotEmpty
                                ? description =
                                    descriptionController.text.toString()
                                : description = "";

                        uploadTransaction(amount, transactionType,
                            selectedCategories, isTaxable, description);

                        AwesomeDialog(
                                context: context,
                                dialogType: DialogType.SUCCES,
                                animType: AnimType.BOTTOMSLIDE,
                                tittle: transactionType + " uploaded",
                                desc: '\$' + amount,
                                btnOkOnPress: () {})
                            .show();

                        resetValues();
                      } else if (selectedCategories.isEmpty) {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.WARNING,
                          animType: AnimType.BOTTOMSLIDE,
                          tittle: "Transaction category missing",
                          desc: 'Select a category for your transaction',
                          btnOkColor: Color(0xfffdb800),
                          btnOkOnPress: () {},
                        ).show();
                      } else {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.WARNING,
                          animType: AnimType.BOTTOMSLIDE,
                          tittle: "Transaction amount missing",
                          desc: 'Add a value for your transaction',
                          btnOkColor: Color(0xfffdb800),
                          btnOkOnPress: () {},
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
      descriptionController.clear();
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
    return FutureBuilder<List>(
      future: tExp, // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        List<Widget> children;

        if (snapshot.hasData) {
          children = <Widget>[
            Container(
              height: SizeConfig.blockSizeVertical * 4.2,
              child: Center(
                child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      for (var item in snapshot.data)
                        CategorySelectorBtn(
                          catItem: item,
                        )
                    ]),
              ),
            )
          ];
        } else if (snapshot.hasError) {
          children = <Widget>[
            NotificationCell(
              message: "Network Error",
              messageColor: Colors.red,
            )
          ];
        } else {
          children = <Widget>[
            NotificationCell(
              message: "Loading...",
              messageColor: Colors.white,
            )
          ];
        }
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: children,
          ),
        );
      },
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
    return FutureBuilder<List>(
      future: tInc, // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        List<Widget> children;

        if (snapshot.hasData) {
          children = <Widget>[
            Container(
              height: SizeConfig.blockSizeVertical * 4.2,
              child: Center(
                child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      for (var item in snapshot.data)
                        CategorySelectorBtn(
                          catItem: item,
                        )
                    ]),
              ),
            )
          ];
        } else if (snapshot.hasError) {
          children = <Widget>[
            NotificationCell(
              message: "Network Error",
              messageColor: Colors.red,
            )
          ];
        } else {
          children = <Widget>[
            NotificationCell(
              message: "Loading...",
              messageColor: Colors.white,
            )
          ];
        }
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: children,
          ),
        );
      },
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

class ExpenseDescription extends StatefulWidget {
  ExpenseDescription({Key key}) : super(key: key);

  @override
  _ExpenseDescriptionState createState() => _ExpenseDescriptionState();
}

class _ExpenseDescriptionState extends State<ExpenseDescription> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.blockSizeHorizontal * 80,
      height: SizeConfig.blockSizeVertical * 5,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.blockSizeHorizontal * 5),
        child: TextField(
          controller: descriptionController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Add a description (optional)',
            labelStyle: TextStyle(
              fontSize: 13,
            ),
          ),
          style: TextStyle(fontSize: 13),
          cursorColor: Colors.grey,
          //textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class ExpenseDescriptionEmptySpace extends StatelessWidget {
  const ExpenseDescriptionEmptySpace({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.blockSizeHorizontal * 80,
      height: SizeConfig.blockSizeVertical * 5,
    );
  }
}

class NotificationCell extends StatelessWidget {
  var message;
  Color messageColor;
  NotificationCell({@required this.message, @required this.messageColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.0),
      child: Text(message,
          style: TextStyle(
            color: messageColor,
            fontWeight: FontWeight.w600,
          )),
    );
  }
}
