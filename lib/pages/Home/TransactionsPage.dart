import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:muhnee/utilities/FirestoreFunctions.dart';
import 'package:muhnee/utilities/SizeConfig.dart';
import 'ExpensePageSingleFile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:intl/intl.dart';

var weeklyTransactions;
var monthlyTransactions;
var curPageIndex;

class TransactionsPage extends StatefulWidget {
  @override
  _TransactionsPageState createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  @override
  void initState() {
    super.initState();
    monthlyTransactions = getMonthlyTransactions();
    weeklyTransactions = getWeeklyTransactions();
  }

  int curPageIndex = 0;

  final Map<int, Widget> logoWidgets = const <int, Widget>{
    0: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6),
        child:
            Text('this week', style: TextStyle(fontWeight: FontWeight.w600))),
    1: Padding(
      padding: EdgeInsets.symmetric(horizontal: 6),
      child: Text('this month', style: TextStyle(fontWeight: FontWeight.w600)),
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
        children: <Widget>[
          // Container(
          //   child: Text("TESTTESTTESTTESTTEST"),
          //   color: Colors.blue,
          // ),

          //     BubbleBottomBar(
          //   opacity: 0.2,
          //   currentIndex: curPageIndex,
          //   onTap: changePage(),
          //   borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          //   elevation: 0,
          //   fabLocation: BubbleBottomBarFabLocation.center, //new
          //   hasNotch: true, //new
          //   hasInk: true, //new, gives a cute ink effect
          //   inkColor: Colors.black12, //optional, uses theme color if not specified
          //   items: <BubbleBottomBarItem>[

          //       BubbleBottomBarItem(backgroundColor: Colors.deepPurple, icon: Icon(Icons.access_time, color: Colors.black,), activeIcon: Icon(Icons.access_time, color: Colors.deepPurple,), title: Text("This week")),
          //       BubbleBottomBarItem(backgroundColor: Colors.indigo, icon: Icon(Icons.blur_on, color: Colors.black,), activeIcon: Icon(Icons.blur_on, color: Colors.indigo,), title: Text("Folders")),
          //   ],
          // ),

          Padding(
            padding: EdgeInsets.only(bottom: 10, top: 10),
            child: CupertinoSlidingSegmentedControl<int>(
              //borderColor: Colors.white,
              // selectedColor: Color(0xff8e91f3),
              //selectedColor: Colors.grey[200],
              // unselectedColor: Colors.white,
              children: logoWidgets,
              onValueChanged: (int val) {
                setState(() {
                  curPageIndex = val;
                });
              },
              groupValue: curPageIndex,
            ),
          ),

          Expanded(
              child: FutureBuilder<List>(
            future: curPageIndex == 0
                ? weeklyTransactions
                : monthlyTransactions, // a previously-obtained Future<String> or null
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              List<Widget> children;

              if (snapshot.hasData) {
                var totalExp = 0.0;
                var totalInc = 0.0;
                var totalNet = 0.0;

                for (var item in snapshot.data)
                  item["type"] == "expense"
                      ? totalExp += item["amount"]
                      : totalInc += item["amount"];

                totalNet = totalInc - totalExp;

                var dateArray = [];

                children = <Widget>[
                  Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: SizeConfig.blockSizeVertical * 0.8),
                      child: SizedBox(
                        height: SizeConfig.blockSizeVertical * 17,
                        width: SizeConfig.blockSizeHorizontal * 70,
                        child: InkWell(
                          child: Container(
                              //         decoration: BoxDecoration(
                              // borderRadius: BorderRadius.circular(10.0),
                              // color: Colors.white,
                              // boxShadow: [
                              //   BoxShadow(
                              //     color: Colors.black.withOpacity(0.25),
                              //     blurRadius: 10.0,
                              //   ),
                              // ]),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  //color: Color(0xff8e91f3),
                                  color: Colors.grey[200]
                                  //border: Border.all(color: Colors.grey)
                                  ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    summaryRow("Income", totalInc.toString()),
                                    summaryRow("Expenses", totalExp.toString()),
                                    summaryRow("Net", totalNet.toString()),
                                  ],
                                ),
                              )),
                          onTap: () {
                            print("Summary Cell Pressed");
                          },
                        ),
                      )),
                  Container(
                      child: Expanded(
                    child: ListView(
                        scrollDirection: Axis.vertical,
                        padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.blockSizeHorizontal * 5,
                        ),
                        children: [
                          for (var item in snapshot.data)
                            TransactionViewCell(
                                amountText: item["amount"].toString(),
                                type: item["type"],
                                category: item["category"],
                                description: item["description"],
                                timestamp: item["timestamp"])
                        ]),
                  ))
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
                      message: "Loading...", messageColor: Colors.grey)
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
          )),
        ],
      )),
    );
  }
}

Widget summaryRow(type, amount) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Text(
         type + ": ",
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
      ),
      type == "Income"
          ? Text(
              "\$ " + amount,
              style: GoogleFonts.varelaRound(
                textStyle: TextStyle(
                  letterSpacing: .5,
                  fontSize: 16,
                  color: Colors.green,
                ),
              ),
            )
          : type == "Expenses"
              ? Text(
                  "\$ " + amount,
                  style: GoogleFonts.varelaRound(
                    textStyle: TextStyle(
                      letterSpacing: .5,
                      fontSize: 16,
                      color: Colors.red,
                    ),
                  ),
                )
              : Text(
                  "\$ " + amount,
                  style: GoogleFonts.varelaRound(
                    textStyle: TextStyle(
                      letterSpacing: .5,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                )
    ],
  );
}

class TransactionViewCell extends StatefulWidget {
  var amountText;
  var type;
  var category;
  var taxable;
  var description;
  var timestamp;

  TransactionViewCell(
      {@required this.amountText,
      @required this.type,
      @required this.category,
      this.taxable,
      @required this.description,
      @required this.timestamp});

  @override
  _TransactionViewCellState createState() => _TransactionViewCellState();
}

class _TransactionViewCellState extends State<TransactionViewCell> {
  Color cellColor1;
  Color cellColor2;

  var cat;
  var tax;

  @override
  Widget build(BuildContext context) {
    if (widget.type == "income") {
      cellColor1 = Color(0xff90cb46);
      cellColor2 = Color(0xff9ed45b);
    } else {
      cellColor1 = Color(0xffe52d27);
      cellColor2 = Color(0xffff0844);
    }

    return Padding(
        padding:
            EdgeInsets.symmetric(vertical: SizeConfig.blockSizeVertical * 0.7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 1, bottom: 3),
              child: Text(DateFormat.yMMMMEEEEd()
                  .format(widget.timestamp.toDate())
                  .toString()),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 6.5,
              child: InkWell(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      // gradient: LinearGradient(
                      //   begin: Alignment.topLeft,
                      //   end: Alignment.bottomRight,
                      //   colors: [cellColor1, cellColor2],
                      // ),
                      color: Colors.grey[200],
                      border: Border.all(color: cellColor1)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            left: SizeConfig.blockSizeVertical * 1),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "\$ ",
                              style: GoogleFonts.varelaRound(
                                textStyle: TextStyle(
                                    letterSpacing: .5,
                                    fontSize: 20,
                                    color: Colors.white),
                              ),
                            ),
                            Text(
                              widget.amountText,
                              style: GoogleFonts.varelaRound(
                                textStyle: TextStyle(
                                    letterSpacing: .5,
                                    fontSize: 25,
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            right: SizeConfig.blockSizeHorizontal * 3),
                        child: Text(
                          widget.category,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  print("Transaction View Cell Pressed");
                },
              ),
            )
          ],
        ));
  }
}
