import 'package:flutter/material.dart';
import 'package:muhnee/utilities/FirestoreFunctions.dart';
import 'package:muhnee/utilities/SizeConfig.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';

// Pull from Firebase

var tExp;
var tInc;

// Send as transaction
var amount = "0";
var transactionType = "income";
var selectedCategory = "";
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
      color: Colors.white,
      // decoration: BoxDecoration(
      //     gradient: LinearGradient(
      //           begin: Alignment.topCenter,
      //           end: Alignment.bottomCenter,
      //           colors: [Colors.grey[100], Colors.white],
      //         ),

      // ),
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
                    ),
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
                    ),
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
        //side: BorderSide(color: Colors.grey[200])
      ),
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
              Text("\$ ",
                  style: TextStyle(
                      fontSize: 45,
                      fontFamily: "SFPro",
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600])),
              Text(amount,
                  style: TextStyle(
                      fontSize: 80,
                      fontFamily: "SFPro",
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600])),
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
          //color: Colors.red,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // ROW FOR BUTTONS

              //         Container(
              //           child: BubbleBottomBar(
              //   opacity: .2,
              //   currentIndex: 0,
              //   onTap: transactionTypeSelector(),
              //   borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              //   elevation: 8,
              //   fabLocation: BubbleBottomBarFabLocation.end, //new
              //   hasNotch: true, //new
              //   hasInk: true, //new, gives a cute ink effect
              //   inkColor: Colors.black12, //optional, uses theme color if not specified
              //   items: <BubbleBottomBarItem>[
              //       BubbleBottomBarItem(backgroundColor: Colors.red, icon: Icon(Icons.dashboard, color: Colors.black,), activeIcon: Icon(Icons.dashboard, color: Colors.red,), title: Text("Home")),
              //       BubbleBottomBarItem(backgroundColor: Colors.deepPurple, icon: Icon(Icons.access_time, color: Colors.black,), activeIcon: Icon(Icons.access_time, color: Colors.deepPurple,), title: Text("Logs")),
              //   ],
              // ),
              //         ),

              // ExpenseDescription(),

              // transactionType == "income"
              //     ? ExpenseDescriptionEmptySpace()
              //     : ExpenseDescription(),

              ExpenseDescription(),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  // Income / Expense Button
                  RaisedButton(
                    child: Text(
                      transactionType[0].toUpperCase().toString() +
                          transactionType.substring(1).toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                    color: incomeExpenseColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      //side: BorderSide(color: Colors.grey[200])
                    ),
                    elevation: 0,
                    onPressed: () {
                      if (transactionType == "income") {
                        setState(() {
                          transactionType = "expense";
                          incomeExpenseColor = Color(0xffE43524);
                          selectedCategory = "";
                        });
                      } else {
                        setState(() {
                          transactionType = "income";
                          incomeExpenseColor = Color(0xffa5d15b);
                          selectedCategory = "";
                          descriptionController.clear();
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

                      if (amount != "0" && selectedCategory != "") {
                        var description;

                        //? All transactions now take description data (optional)
                        // transactionType == "income"
                        //     ? description = ""
                        //     : descriptionController.text.isNotEmpty
                        //         ? description =
                        //             descriptionController.text.toString()
                        //         : description = "";

                        descriptionController.text.isNotEmpty
                            ? description =
                                descriptionController.text.toString()
                            : description = null;

                        uploadTransaction(amount, transactionType,
                            selectedCategory, isTaxable, description);

                        AwesomeDialog(
                                context: context,
                                dialogType: DialogType.SUCCES,
                                animType: AnimType.BOTTOMSLIDE,
                                tittle: (transactionType[0].toUpperCase() +
                                        transactionType
                                            .substring(1)
                                            .toString()) +
                                    " uploaded",
                                desc: selectedCategory + ': \$' + amount,
                                btnOkOnPress: () {})
                            .show();

                        //TODO : FIRST THING IN THE MONRING
                        //! resetValues();

                        if (transactionType == "expense") {
                          setState(() {
                            descriptionController.clear();
                          });
                        }
                      } else if (selectedCategory == "") {
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

              //TODO: this could be solved much better - in a single line by changing tInc to tExp
              transactionType == "income"
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
      transactionType = "income";
      isTaxable = false;
      descriptionController.clear();
      incomeExpenseColor = Color(0xffa5d15b);
    });

    print(amount);
    print(transactionType);
    print(isTaxable);
  }

  transactionTypeSelector() {
    if (transactionType == "income") {
      setState(() {
        transactionType = "expense";
        //incomeExpenseColor = Color(0xffE43524);
        selectedCategory = "";
      });
    } else {
      setState(() {
        transactionType = "income";
        //incomeExpenseColor = Color(0xffa5d15b);
        selectedCategory = "";
        descriptionController.clear();
      });
    }
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
          var length = snapshot.data.length;
          var items = [];
          // selectedCategory = snapshot.data[0];

          for (var item in snapshot.data) {
            items.add(item);
          }

          children = <Widget>[
            Container(
              height: SizeConfig.blockSizeVertical * 5,
              child: Center(
                child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      CategorySelectorBtn(items: items, length: length)
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
              messageColor: Colors.grey,
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
          var length = snapshot.data.length;
          var items = [];
          // selectedCategory = snapshot.data[0];

          for (var item in snapshot.data) {
            items.add(item);
          }

          children = <Widget>[
            Container(
              height: SizeConfig.blockSizeVertical * 5,
              child: Center(
                child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      CategorySelectorBtn(items: items, length: length)
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
              messageColor: Colors.grey,
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
  var items;
  var length;

  CategorySelectorBtn({@required this.items, @required this.length});

  @override
  _CategorySelectorBtnState createState() => _CategorySelectorBtnState();
}

class _CategorySelectorBtnState extends State<CategorySelectorBtn> {
  Color unselectedBtnColor = Colors.grey[300];

  int _value = 0;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List<Widget>.generate(
        widget.length,
        (int index) {
          //! this padding is dodgy
          return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.blockSizeHorizontal * 1.2,
              ),
              child: ChoiceChip(
                label: Padding(
                  padding: EdgeInsets.symmetric(vertical: 7, horizontal: 3),
                  child: Text(
                    widget.items[index],
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                ),
                backgroundColor: Colors.grey[300],
                selectedColor: Color(0xff8e91f3),
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                selected: _value == index,
                onSelected: (bool selected) {
                  setState(() {
                    _value = selected ? index : null;

                    selectedCategory = selected ? widget.items[index] : "";

                    print(selectedCategory);
                  });
                },
              ));
        },
      ).toList(),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Padding(
  //     padding: EdgeInsets.symmetric(horizontal: 6.0),
  //     child: RaisedButton(
  //       child: Text(
  //         widget.catItem,
  //         style: TextStyle(color: Colors.white),
  //       ),
  //       color: unselectedBtnColor,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(10.0),
  //       ),
  //       elevation: 0,
  //       onPressed: () {
  //         if (unselectedBtnColor == Colors.grey[300]) {
  //           setState(() {
  //             unselectedBtnColor = Color(0xff8e91f3);
  //             selectedCategories.add(widget.catItem);
  //             print(selectedCategories);
  //           });
  //         } else {
  //           setState(() {
  //             unselectedBtnColor = Colors.grey[300];
  //             selectedCategories.remove(widget.catItem);
  //             print(selectedCategories);
  //           });
  //         }
  //       },
  //     ),
  //   );

  //}
}

class ExpenseDescription extends StatefulWidget {
  ExpenseDescription({Key key}) : super(key: key);

  @override
  _ExpenseDescriptionState createState() => _ExpenseDescriptionState();
}

class _ExpenseDescriptionState extends State<ExpenseDescription> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: SizeConfig.blockSizeHorizontal * 60,
          height: SizeConfig.blockSizeVertical * 5,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.blockSizeHorizontal * 5),
            child: TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)),
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
        ),

        // Recurring btn

        RecurringBtn(),
      ],
    );
  }
}

class RecurringBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 40,
      child: RaisedButton(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius:  BorderRadius.circular(10.0),
        side: BorderSide(color: Colors.grey[300])
),
      elevation: 0,
      child: Icon(Icons.loop),
      onPressed: () {
        Scaffold.of(context).showSnackBar(SnackBar(
          //behavior: SnackBarBehavior.floating,
          //elevation: 0,
          //           shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.circular(10.0),
          // ),
          // duration: Duration(seconds: 1),
          backgroundColor: Colors.grey[300],
          content: Text(
            "Recurring every: ",
            style: TextStyle(color: Colors.black),
          ),
        ));
      },
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
    // return Padding(
    //   padding: EdgeInsets.symmetric(horizontal: 6.0),
    //   child: Text(message,
    //       style: TextStyle(
    //         color: messageColor,
    //         fontWeight: FontWeight.w600,
    //       )),
    // );

    return RaisedButton(
      color: Colors.white,
      elevation: 0,
      child: Text(message,
          style: TextStyle(
            color: messageColor,
            fontWeight: FontWeight.w600,
          )),
      onPressed: () {
        //do nothing
      },
    );
  }
}
