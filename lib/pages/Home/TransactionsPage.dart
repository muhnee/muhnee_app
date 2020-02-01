import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:muhnee/utilities/FirestoreFunctions.dart';
import 'package:muhnee/utilities/SizeConfig.dart';
import 'ExpensePageSingleFile.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

var weeklyTransactions;
var monthlyTransactions;
var curPageIndex;

var categoryInfoIncome;
var categoryInfoExpense;

class TransactionsPage extends StatefulWidget {
  @override
  _TransactionsPageState createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  @override
  void initState() {
    super.initState();
    //monthlyTransactions = getMonthlyTransactions();
    weeklyTransactions = getWeeklyTransactionsCloud();
    categoryInfoIncome = getCurrentSummaryforTransactions("income");
    categoryInfoExpense = getCurrentSummaryforTransactions("expense");
  }

  //! used for week to month switch

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
    //Shader is for gradient text
    final Shader linearGradientGreen = LinearGradient(
      colors: <Color>[Color(0xff90cb46), Color(0xff9ed45b)],
    ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

    final Shader linearGradientRed = LinearGradient(
      colors: <Color>[Color(0xffe52d27), Color(0xffff0844)],
    ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

    final Shader linearGradientPurple = LinearGradient(
      colors: <Color>[Color(0xff8e91f3), Color(0xff9D78F3)],
    ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
        children: <Widget>[
          //! Segmented controller
          // Padding(
          //   padding: EdgeInsets.only(bottom: 10, top: 10),
          //   child: CupertinoSlidingSegmentedControl<int>(

          //     children: logoWidgets,
          //     onValueChanged: (int val)
          //       setState(() {
          //         curPageIndex = val;
          //       });
          //     },
          //     groupValue: curPageIndex,
          //   ),
          // ),

          Expanded(
              child: FutureBuilder<dynamic>(
            // future: curPageIndex == 0
            //     ? weeklyTransactions
            //     : monthlyTransactions, // a previously-obtained Future<String> or null
            future: weeklyTransactions,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              List<Widget> children;

              if (snapshot.hasData) {
                var totalExp = 0.0;
                var totalInc = 0.0;
                var totalNet = 0.0;

                // var savingsGoal = getWeeklySavingsGoal();

                // var reachedGoalPercent = total

                for (var item in snapshot.data)
                  item["type"] == "expense"
                      ? totalExp += item["amount"]
                      : totalInc += item["amount"];

                totalNet = totalInc - totalExp;

                children = <Widget>[
                  // Stats section

                  // ListView
                  Container(
                      child: Expanded(
                    child: ListView(scrollDirection: Axis.vertical,
                        // padding: EdgeInsets.symmetric(
                        //   horizontal: SizeConfig.blockSizeHorizontal * 5,
                        // ),
                        children: [
                          // Not Scrollable b4

                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 70,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: SizeConfig.blockSizeVertical * 1.5,
                                ),

                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal:
                                        SizeConfig.blockSizeHorizontal * 5,
                                  ),
                                  child: Text(
                                    "This week you've",
                                    style: TextStyle(
                                      fontSize: 30.0,
                                      fontFamily: "SFPro",
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff1d1c1f),
                                      //foreground: Paint()..shader = linearGradientPurple
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: SizeConfig.blockSizeVertical * 1,
                                ),

                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal:
                                        SizeConfig.blockSizeHorizontal * 5,
                                  ),
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        "Earned: ",
                                        style: new TextStyle(
                                            fontSize: 25.0,
                                            fontFamily: "SFPro",
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey[400]
                                            //foreground: Paint()..shader = linearGradientPurple
                                            ),
                                      ),
                                      Text(
                                        "\$" + totalInc.toString(),
                                        style: new TextStyle(
                                            fontSize: 25.0,
                                            fontFamily: "SFPro",
                                            fontWeight: FontWeight.bold,
                                            foreground: Paint()
                                              ..shader = linearGradientGreen),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: SizeConfig.blockSizeVertical * 1,
                                ),

                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal:
                                        SizeConfig.blockSizeHorizontal * 5,
                                  ),
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        "Spent:   ",
                                        style: TextStyle(
                                            fontSize: 25.0,
                                            fontFamily: "SFPro",
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey[400]
                                            //foreground: Paint()..shader = linearGradientPurple
                                            ),
                                      ),
                                      Text(
                                        "\$" + totalExp.toString(),
                                        style: TextStyle(
                                            fontSize: 25.0,
                                            fontFamily: "SFPro",
                                            fontWeight: FontWeight.bold,
                                            foreground: Paint()
                                              ..shader = linearGradientRed),
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(
                                  height: SizeConfig.blockSizeVertical * 1,
                                ),

                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal:
                                        SizeConfig.blockSizeHorizontal * 5,
                                  ),
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        "Saved:  ",
                                        style: TextStyle(
                                            fontSize: 25.0,
                                            fontFamily: "SFPro",
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey[400]
                                            //foreground: Paint()..shader = linearGradientPurple
                                            ),
                                      ),
                                      totalNet < 0
                                          ? Text(
                                              "- \$" +
                                                  totalNet
                                                      .toString()
                                                      .substring(1),
                                              style: TextStyle(
                                                  fontSize: 25.0,
                                                  fontFamily: "SFPro",
                                                  fontWeight: FontWeight.bold,
                                                  foreground: Paint()
                                                    ..shader =
                                                        linearGradientRed),
                                            )
                                          : Text(
                                              "\$" + totalNet.toString(),
                                              style: TextStyle(
                                                  fontSize: 25.0,
                                                  fontFamily: "SFPro",
                                                  fontWeight: FontWeight.bold,
                                                  foreground: Paint()
                                                    ..shader =
                                                        linearGradientGreen),
                                            )

                                      //ends here
                                    ],
                                  ),
                                ),

                                SizedBox(
                                  height: SizeConfig.blockSizeVertical * 2.5,
                                ),

                                //  ! Categories

                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal:
                                        SizeConfig.blockSizeHorizontal * 5,
                                  ),
                                  child: Text(
                                    "Categories",
                                    style: TextStyle(
                                      fontSize: 30.0,
                                      fontFamily: "SFPro",
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff1d1c1f),
                                      //foreground: Paint()..shader = linearGradientPurple
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: SizeConfig.blockSizeVertical * 1,
                                ),

                                CategoryInfoSection(categoryInfoIncome),

                                CategoryInfoSection(categoryInfoExpense),

                                SizedBox(
                                  height: SizeConfig.blockSizeVertical * 2.5,
                                ),

                                //!Transaction

                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal:
                                        SizeConfig.blockSizeHorizontal * 5,
                                  ),
                                  child: Text(
                                    "Your transactions",
                                    style: TextStyle(
                                      fontSize: 30.0,
                                      fontFamily: "SFPro",
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff1d1c1f),
                                      //foreground: Paint()..shader = linearGradientPurple
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: SizeConfig.blockSizeVertical * 0.3,
                                ),
                              ],
                            ),
                          ),

                          //! Transactions

                          for (var item in snapshot.data)
                            Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal:
                                      SizeConfig.blockSizeHorizontal * 5,
                                ),
                                child: TransactionViewCell(
                                  amountText: item["amount"].toString(),
                                   type: item["type"],
                                   category: item["category"],
                                  // description: item["description"],
                                   timestamp: item["timestamp"],
                                   recurring: item["recurringDays"],
                                )),
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
                      message: "Loading...", messageColor: Colors.grey[200])
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


class TransactionViewCell extends StatefulWidget {
  var amountText;
  var type;
  var category;
  var taxable;
  var description;
  var timestamp;
  var recurring;

  TransactionViewCell(
      { @required this.amountText,
       @required this.type,
       this.category,
       this.taxable,
       this.description,
      @required this.timestamp,
       this.recurring});

  @override
  _TransactionViewCellState createState() => _TransactionViewCellState();
}

class _TransactionViewCellState extends State<TransactionViewCell> {
  //Color cellColor1;
  Color cellColor2;

  DateTime timestampDate ;

  @override
  Widget build(BuildContext context) {

    timestampDate = DateTime.parse(widget.timestamp);

    if (widget.type == "income") {
      //cellColor1 = Color(0xff90cb46);
      cellColor2 = Color(0xff9ed45b);
    } else {
      // cellColor1 = Color(0xffe52d27);
      cellColor2 = Color(0xffff0844);
    }

    return Padding(
        padding:
            EdgeInsets.symmetric(vertical: SizeConfig.blockSizeVertical * 0.85),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //! outside date
            // Padding(
            //   padding: EdgeInsets.only(left: 1, bottom: 3),
            //   child: Text(
            //     DateFormat.MMMMEEEEd()
            //         .format(widget.timestamp.toDate())
            //         .toString(),
            //     style: TextStyle(color: Colors.grey[600], fontSize: 12, fontWeight: FontWeight.w600),
            //   ),
            // ),

            SizedBox(
              // height: SizeConfig.blockSizeVertical * 6.5,
              height: 58,

              child: InkWell(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    // gradient: LinearGradient(
                    //   begin: Alignment.topLeft,
                    //   end: Alignment.bottomRight,
                    //   colors: [
                    //     Colors.grey[100],
                    //     cellColor2.withOpacity(0.3)
                    //   ], //? [cellColor1, cellColor2],
                    // ),
                    color: Colors.grey[100],
                    //color: cellColor2,
                    //  boxShadow: [
                    //   BoxShadow(
                    //     color: Colors.black.withOpacity(0.06),
                    //     blurRadius: 15.0
                    //   ),
                    // ]
                    //border: Border.all(color: cellColor2)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            left: SizeConfig.blockSizeHorizontal * 3),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  widget.category.toString(), //! change to category
                                  style: TextStyle(
                                    //  color: Colors.grey[600],
                                    color: Color(0xff1d1c1f),

                                    //color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                widget.recurring != 0
                                    ? Row(
                                        children: <Widget>[
                                          Text("  "),
                                          Icon(
                                            Icons.loop,
                                            size: 10,
                                            color: Color(0xff1d1c1f),
                                          ),
                                          Text(
                                            widget.recurring.toString(),
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                              //color: Colors.white,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      )
                                    : Text("")
                              ],
                            ),

                            



                            Text(
                              DateFormat.EEEE()
                                      .format(timestampDate)
                                      .toString() +
                                  ", " +
                                  DateFormat.MMMd()
                                      .format(timestampDate)
                                      .toString(),
                              style: TextStyle(
                                  color: Colors.grey[400],
                                  //color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600),
                            ),



                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            right: SizeConfig.blockSizeVertical * 1),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "\$ ",
                              style: TextStyle(
                                  letterSpacing: .5,
                                  fontSize: 17, //15?
                                  // color: cellColor2,
                                  color: cellColor2,
                                  fontFamily: "SFPro",
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(widget.amountText,
                                style: TextStyle(
                                  letterSpacing: 1,
                                  fontSize: 17,
                                  // color: cellColor2,
                                  color: cellColor2,
                                  fontFamily: "SFPro",
                                  fontWeight: FontWeight.w600,
                                )),
                          ],
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

class CategoryInfoSection extends StatefulWidget {
  var categoryFuture;
  CategoryInfoSection(this.categoryFuture);

  @override
  _CategoryInfoSectionState createState() => _CategoryInfoSectionState();
}

class _CategoryInfoSectionState extends State<CategoryInfoSection> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: widget.categoryFuture,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        List<Widget> children;
        Color txtColor;

        if (snapshot.hasData) {
          widget.categoryFuture == categoryInfoIncome
              ? txtColor = Color(0xff9ed45b)
              : txtColor = Color(0xffff0844);

          children = <Widget>[
            Container(
              height: SizeConfig.blockSizeVertical * 10,
              child: Center(
                child: ListView(
                    shrinkWrap: false,
                    scrollDirection: Axis.horizontal,
                    children: [
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 5,
                      ),
                      SizedBox(
                          //width: SizeConfig.blockSizeHorizontal * 28,

                          width: 115,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                widget.categoryFuture == categoryInfoIncome
                                    ? "Income "
                                    : "Expenses",
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontFamily: "SFPro",
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[400]),
                              ),
                            ],
                          )),
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 3,
                      ),
                      for (var item in snapshot.data)
                        Center(
                            child: Padding(
                          padding: EdgeInsets.only(
                            right: SizeConfig.blockSizeHorizontal * 2.5,
                            //  top: SizeConfig.blockSizeHorizontal * 0.7,
                            //  bottom: SizeConfig.blockSizeHorizontal * 0.7,
                          ),
                          child: CategoryBtnView(
                              item["name"], item["amount"], txtColor),
                        ))
                    ]),
              ),
            )

            //category info
          ];
        } else if (snapshot.hasError) {
          children = <Widget>[
            Center(
                child: NotificationCell(
              message: "Network Error",
              messageColor: Colors.red,
            ))
          ];
        } else {
          children = <Widget>[
            Center(
                child: NotificationCell(
                    message: "Loading...", messageColor: Colors.grey))
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

  Widget CategoryBtnView(catName, amount, txtColor) {
    return SizedBox(
      width: SizeConfig.blockSizeHorizontal * 30,
      // height: SizeConfig.blockSizeVertical * 8.5,
      height: 75,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.grey[100],
          //color: Colors.white,
          //border: Border.all(color: Colors.grey)
          //color: Color(0xffd6d6d6),
          //  boxShadow: [
          //             BoxShadow(
          //               color: Colors.black.withOpacity(0.06),
          //               blurRadius: 15.0,
          //             ),
          //           ]
        ),
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  catName.toString(),
                  style: TextStyle(
                    color: Color(0xff1d1c1f),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  "\$ " + amount.toString(),
                  style:
                      TextStyle(color: txtColor, fontWeight: FontWeight.w600),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
